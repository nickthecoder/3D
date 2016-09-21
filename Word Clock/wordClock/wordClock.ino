/*
    Tells the time using words rather than numbers. For example :
        It's nearly ten past eight
        It's just gone half past two
        It's twenty five to three
        It's four o'clock
      
    The words are arranged like so :
        It's just gone nearly
        twenty five ten
        quarter to half past
        one two three four
        five six seven eight
        nine eleven twelve
        set mins ten o'clock
        
    The last line is for setting the clock, but I may use an automatic process rather than a manual one.
    
    Each word can be turned on/off, and the words are arranged so that you can form all possible times
    quite easily. Uses the same technology as seven segment displays, i.e. a box with LED(s) inside, 
    and a patterned hole through which light emerges (in this case the pattern is a whole word).
    
    The words are different lengths, and therefore have different numbers of LEDs. With a 12V supply
    and 3.0V forward current, I've chosen to run the LEDs under their 20mA rating, using resistor values : 
    
      2 LEDs in series : 470ohm
      3 LEDs in series : 150ohm

    For more than 3 LEDs, we create parallel circuits using the above.
      4 LEDs : 2 + 2 (total of  ohm)
      5 LEDs : 2 + 3 (total of  ohm)
      6 LEDs : 3 + 3 (total of  ohm)
      7 LEDs : 2,2,3 (total of  ohm)
      8 LEDs : 3,3,2 (total of  ohm)
      9 LEDs : 3,3,3 (total of  ohm)
      10 LEDs : 3,3,2,2,2 (total of ohm)

    And therefore the base resitor for the NPN transistors are : (RB = 0.2 × RL × hFE, using hFE of 100...)
      2 LEDs : k
      3 LEDs : k
      4 LEDs : k
      5 LEDs : k
      6 LEDs : k
      7 LEDs : 
      8 LEDs : k
      9 LEDs :  ohm
     10 LEDs :  ohm
   I believe these are the upper values, and can be rounded (to ensure that the gate is fully saturated), a lower value will
   equally work, all be it with a slightly higher current.
     
   http://www.petervis.com/Raspberry_PI/Driving_LEDs_with_CMOS_and_TTL_Outputs/Driving_an_LED_Using_Transistors.html
   
   The 12V supply is to be fed commonly to all boxes (via resitors to each branch of LEDs) and the anodes are wired to the collector of the NPN LED driver.
   There is a single transistor per box, a single base restistor per transistor, and a current limiting load resistor for each branch of LEDs.

   I'll use 3x 595 8-Bit Shift Registers, giving 24 outputs, and ideally I need 25. So either the "It's" or the "set" box will be handled independantly.

   The time is kept using a dedicated real time clock chip, with battery backup using a small CR2032 battery,

   Ideas
   =====
   
   Use a single PWM pin through a transistor on the cathode side, so that all LEDs can be dimmed. (Note requires reverse logic; high value -> low intensity).
   
   Include a light sensor, so that the LEDs are not as bright at night as during the day.
   
   Could incorporate a WiFi module, and use an intranet connection to update the time every hour? Maybe simpler than coding it using buttons!
   Power the wifi module each hour, send the request, and then power it off.
   Flash the "set" if the time hasn't been updated for a while.
     Could gradually increase its intensity - easy if "set" is on its own pin, rather than the shift registers.

  Alternatively, use up/down and mode buttons to set the time
  
  Or use an IR remote control instead of / as well as physical buttons.

*/

#include <abstractIO.h>;
#include <abstract_shift595.h>;

// Define the pins used
#define SHIFT_CLOCK 12
#define SHIFT_DATA 11
#define SHIFT_LATCH 8

#define PIN_MINUS 7
#define PIN_MODE 6
#define PIN_PLUS 5

// Number of shift register bytes
#define SHIFT_CHIPS 3

// Define the index of each box within the shift register array.
#define BOX_ITS 0
#define BOX_JUST_GONE 1
#define BOX_NEARLY 2
#define BOX_TWENTY 3
#define BOX_FIVE 4
#define BOX_TEN 5
#define BOX_QUARTER 6
#define BOX_TO 7
#define BOX_HALF 8
#define BOX_PAST 9
#define HOUR_ONE 10
#define HOUR_TWELVE 21
#define BOX_SET 22
#define BOX_MINS 23
#define BOX_TENS 24
#define BOX_OCLOCK 25

Shift595 shiftRegister = Shift595( SHIFT_LATCH, SHIFT_CLOCK, SHIFT_DATA, SHIFT_CHIPS );

InputButton *buttonMinus;
InputButton *buttonPlus;
InputButton *buttonMode;

#define MODES 4

#define MODE_TEST 0
#define MODE_TIME 1
#define MODE_HOUR 2
#define MODE_TENS 3
#define MODE_MINS 4


int mode = MODE_TEST;

void clearBuffer( byte value=0 )
{
    for ( int i = 0; i < SHIFT_CHIPS; i ++ ) {
        shiftRegister.buffer[i] = value;
    }
}

void setup()
{
    buttonMinus = new InputButton( (new SimpleInput( PIN_MINUS, LOW, true ))->debounced() );
    buttonPlus  = new InputButton( (new SimpleInput( PIN_PLUS,  LOW, true ))->debounced() );
    buttonMode  = new InputButton( (new SimpleInput( PIN_MODE,  LOW, true ))->debounced() );
   
    
    // initialize digital pin 13 as an output.
    pinMode(13, OUTPUT);
  
    clearBuffer( 0 );
    shiftRegister.update();
    delay(100);
    clearBuffer( 255 );
    shiftRegister.update();
    delay(100);

    // Display each box in turn, as a simple test pattern
    for ( int i = 0; i < SHIFT_CHIPS*8; i ++ ) {
        shiftRegister.set( i );
        shiftRegister.update();
        delay( 200 );
        shiftRegister.reset( i );                
        shiftRegister.update();
    }

    clearBuffer( 255 );
    shiftRegister.update();
}

byte n = 128;

void loop()
{
    if (buttonMode->pressed()) {
        mode ++;
        if (mode >= MODES) {
            mode = 0;
        }
    }
  
    if ( mode == MODE_TIME ) {
        modeTime();
    } else if ( mode == MODE_TEST ) {
        modeTest();
    }
}

void modeTest()
{
    digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(100);

    digitalWrite(13, LOW);    // turn the LED off by making the voltage LOW
    clearBuffer( n );         
    shiftRegister.update();
    n = n >> 1;
    //n = n + 1;
    if ( n == 0) {
        n = 128;
    }
    delay(800);
}

void modeTime()
{
    // Read the time
    // During testing, don't use the real time clock, just run through all combinations.
    long now = millis() / 1000;

    int minutes = now % 60;
    int hour = (now / 60) % 12;

    // Turn off all LEDs (in the buffer only)
    clearBuffer();
    
    // Work out which boxes to light
    displayTime( hour, minutes );    
    
    // Update the display (moving the buffered values into the shift register)
    shiftRegister.update();    
}


void displayTime( int hour, int minutes )
{
    // Turn on "It's"
    shiftRegister.set( BOX_ITS );

    // The number of minutes away from 5,10,15 etc.
    int subFive = minutes % 5; 
    
    // Range of 0..11 representing minutes : 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55
    int nearestFive = minutes / 5; 
    if ( subFive > 2 ) {
        nearestFive = (nearestFive + 1) % 12;
        // Turn on "nearly"
        shiftRegister.set( BOX_NEARLY );
        
    } else if ( subFive > 0 ) {
        // Turn on "just gone"
        shiftRegister.set( BOX_JUST_GONE );

    }
    
    // Check for "to", "past" or "o'clock"
    if ( nearestFive == 0 ) {
        // Turn on "o'clock"
        shiftRegister.set( BOX_OCLOCK );

    } else if ( nearestFive > 6 ) {
        hour = (hour + 1) % 12;
        // Turn on "to"
        shiftRegister.set( BOX_TO );
    } else {
        // Turn on "past"
        shiftRegister.set( BOX_PAST );
    }
    
    // Turn on the appropriate minutes : "five ten quarter twenty half"
    
    if ( (nearestFive == 1) || (nearestFive == 5) || (nearestFive == 7) || (nearestFive = 11) ) {
        // Turn on "five"
        shiftRegister.set( BOX_FIVE );
    }
    
    if ( (nearestFive == 2) || (nearestFive == 10) ) {
        // Turn on "ten"
        shiftRegister.set( BOX_TEN );
    }
    
    if ( (nearestFive == 3) || (nearestFive == 9) ) {
        // Turn on "quarter"
        shiftRegister.set( BOX_QUARTER );
    }
    
    if ( (nearestFive == 4) || (nearestFive == 5) || (nearestFive == 7) || (nearestFive=8) ) {
        // Turn on "twenty
        shiftRegister.set( BOX_TWENTY );
    }
    if (nearestFive == 6) {
        // Turn on "half"
        shiftRegister.set( BOX_HALF );
    }

    // The hour
        
    if ( hour == 0 ) {
        // turn on "twelve"
        shiftRegister.set( HOUR_TWELVE );
    } else {
        // turn on one of "one".."eleven"
        shiftRegister.set( HOUR_ONE + hour - 1 );
    }
    
}



