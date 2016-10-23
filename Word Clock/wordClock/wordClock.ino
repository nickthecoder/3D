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
    
   The 12V supply is to be fed commonly to all boxes (via resitors to each branch of LEDs) and the anodes are wired to the collector of the NPN LED driver.
   There is a single transistor per box, a single base resistor per transistor, and a current limiting load resistor for each branch of LEDs.

   It use 3x 595 8-Bit Shift Registers, giving 24 outputs, and ideally I need 25. So either the "It's" or the "set" box will be handled independantly.

   The time is kept using a dedicated real time clock chip, with battery backup using a small CR2032 battery,

   Future Ideas
   ============
   
   Use a single PWM pin through a transistor on the cathode side, so that all LEDs can be dimmed. (Note requires reverse logic; high value -> low intensity).
   
   Include a light sensor, so that the LEDs are not as bright at night as during the day.
   
   Could incorporate a WiFi module, and use an intranet connection to update the time every hour? Maybe simpler than coding it using buttons!
   Power the wifi module each hour, send the request, and then power it off.
   Flash the "set" if the time hasn't been updated for a while.
     Could gradually increase its intensity - easy if "set" is on its own pin, rather than the shift registers.

  Alternatively, use up/down and mode buttons to set the time
  
  Or use an IR remote control instead of / as well as physical buttons.
*/

#include <Wire.h>
#include <abstractIO.h>;
#include <abstract_shift595.h>;

#include "realTimeClock.h"

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
#define BOX_ITS 16
#define BOX_JUST_GONE 17
#define BOX_NEARLY 18

#define BOX_QUARTER 19
#define BOX_TO 20
#define BOX_HALF 21
#define BOX_PAST 22

#define BOX_TWENTY 23
#define BOX_FIVE 8
#define BOX_TEN 9

byte HOURS[12] = { 10,11,12,13,14,15,0,1,2,7,3,4 };

#define BOX_MINS 6
#define BOX_OCLOCK 5
//#define BOX_SET 


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


int mode = MODE_TIME;

RealTimeClock *clock;

void clearBuffer( byte value=0 )
{
    for ( int i = 0; i < SHIFT_CHIPS; i ++ ) {
        shiftRegister.buffer[i] = value;
    }
}

void setup()
{
    Serial.begin( 9600 );
    Serial.println( "Setup begin" );

    clock = new RealTimeClock();
    Serial.println( "Initialised RTC" );
    
    buttonMinus = new InputButton( (new SimpleInput( PIN_MINUS, LOW, true ))->debounced() );
    buttonPlus  = new InputButton( (new SimpleInput( PIN_PLUS,  LOW, true ))->debounced() );
    buttonMode  = new InputButton( (new SimpleInput( PIN_MODE,  LOW, true ))->debounced() );
   
    
    // initialize digital pin 13 as an output.
    pinMode(13, OUTPUT);

    clearBuffer( 255 );
    shiftRegister.update();
    
    mode = MODE_TIME;
    
    // As I haven't coded the "set clock" feature yet, I'm setting the clock by hard coding it, uploading,
    // and the commenting it out again.
    //clock->minute=19;
    //clock->hour=7;
    //clock->set();
    
    Serial.println( "Setup complete" );
}

void testWords()
{
    Serial.println( "testWords Line 1");
    testWord( BOX_ITS );  
    testWord( BOX_JUST_GONE );  
    testWord( BOX_NEARLY );  
    Serial.println( "testWords Line 2");
    testWord( BOX_TWENTY );  
    testWord( BOX_FIVE );  
    testWord( BOX_TEN ); 
    
    Serial.println( "testWords Line 3");
    testWord( BOX_QUARTER );  
    testWord( BOX_TO );    
    testWord( BOX_HALF );
    testWord( BOX_PAST );
    
    Serial.println( "testWords Hours");
    for ( int i = 1; i <= 12; i ++ ) {
        testWord( HOURS[i-1] );
    }
    
    Serial.println( "testWords last line");
    testWord( BOX_MINS );  
    testWord( BOX_OCLOCK );  
}

void testWord( int i )
{
    clearBuffer( 0 );
    shiftRegister.set( i );
    shiftRegister.update();
    delay( 800 );
}

int testByButtonIndex = 0;

void testByButton()
{
    if (buttonMode->pressed()) {
        Serial.println( "Pressed" );
        testByButtonIndex ++;
        if (testByButtonIndex >= 25 ) {
            testByButtonIndex = 0;
        }
    }
    clearBuffer( 0 );
    shiftRegister.set( testByButtonIndex );
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
        //modeTest();
        //testWords();
        //testByButton();
        modeRace();
    }
}

void modeTest()
{
    digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(100);
    clock->read();
    Serial.print( "Seconds " ); Serial.println( clock->second );
    Serial.print( "Minutes " ); Serial.println( clock->minute );
    Serial.print( "Hour    " ); Serial.println( clock->hour );

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

/*
  Race through all the possible times, one minute is compressed to 1 second.
  Start at 12:00.
*/
void modeRace()
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
    delay( 500 );
}

void modeTime()
{
    clock->read();

    // Turn off all LEDs (in the buffer only)
    clearBuffer();
    
    // Work out which boxes to light
    displayTime( clock->hour % 12, clock->minute );    
    
    // Update the display (moving the buffered values into the shift register)
    shiftRegister.update();
    delay( 500 );    
}

void displayTime( int hour, int minutes )
{
    Serial.print( hour );
    Serial.print(":");
    Serial.println( minutes );

    // Turn on "It's"
    shiftRegister.set( BOX_ITS );

    // The number of minutes away from 5,10,15 etc.
    int subFive = minutes % 5; 
    
    // Range of 0..11 representing minutes : 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55
    int nearestFive = minutes / 5;
    
    // Are we nearer to the NEXT five minute mark?
    if ( subFive > 2 ) {
        // If we are approching an hour, then it will be "nearly XX O'clock", where XX is the NEXT hour.
        if (nearestFive == 11) {
            nearestFive = 0;
            hour ++;
        } else {
            nearestFive ++;
        }
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
    
    if ( (nearestFive == 1) || (nearestFive == 5) || (nearestFive == 7) || (nearestFive == 11) ) {
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
    
    if ( (nearestFive == 4) || (nearestFive == 5) || (nearestFive == 7) || (nearestFive == 8) ) {
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
        shiftRegister.set( HOURS[11] );
    } else {
        // turn on one of "one".."eleven"
        shiftRegister.set( HOURS[hour-1] );
    }
    
}



