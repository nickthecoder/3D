#include <Arduino.h>
#include <Wire.h>

#include "realTimeClock.h"

#define DS3231_I2C_ADDRESS 0x68

// Convert normal decimal numbers to binary coded decimal
byte decToBcd(byte val)
{
  return( (val/10*16) + (val%10) );
}
// Convert binary coded decimal to normal decimal numbers
byte bcdToDec(byte val)
{
  return( (val/16*10) + (val%16) );
}


void setDS3231time(byte second, byte minute, byte hour, byte dayOfWeek, byte dayOfMonth, byte month, byte year)
{
  // sets time and date data to DS3231
  Wire.beginTransmission(DS3231_I2C_ADDRESS);
  Wire.write(0); // set next input to start at the seconds register
  Wire.write(decToBcd(second)); // set seconds
  Wire.write(decToBcd(minute)); // set minutes
  Wire.write(decToBcd(hour)); // set hours
  Wire.write(decToBcd(dayOfWeek)); // set day of week (1=Sunday, 7=Saturday)
  Wire.write(decToBcd(dayOfMonth)); // set date (1 to 31)
  Wire.write(decToBcd(month)); // set month
  Wire.write(decToBcd(year)); // set year (0 to 99)
  Wire.endTransmission();
}

void readDS3231time(byte *second, byte *minute, byte *hour, byte *dayOfWeek, byte *dayOfMonth, byte *month, byte *year)
{
  Wire.beginTransmission(DS3231_I2C_ADDRESS);
  Wire.write(0); // set DS3231 register pointer to 00h
  Wire.endTransmission();
  Wire.requestFrom(DS3231_I2C_ADDRESS, 7);
  // request seven bytes of data from DS3231 starting from register 00h
  *second = bcdToDec(Wire.read() & 0x7f);
  *minute = bcdToDec(Wire.read());
  *hour = bcdToDec(Wire.read() & 0x3f);
  *dayOfWeek = bcdToDec(Wire.read());
  *dayOfMonth = bcdToDec(Wire.read());
  *month = bcdToDec(Wire.read());
  *year = bcdToDec(Wire.read());
}


void RealTimeClock::set()
{
    setDS3231time( this->second, this->minute, this->hour, 1,1,1,1 );
}

void RealTimeClock::read()
{
    byte doy;
    byte dom;
    byte month;
    byte year;
    readDS3231time( &(this->second), &(this->minute), &(this->hour), &doy, &dom, &month, &year );
    
    Serial.print( "Time " );Serial.print( this->hour ); Serial.print(":"); Serial.print( this->minute ); Serial.print( ":" );Serial.println( this->second );
    Serial.print( "Date " );Serial.print( year ); Serial.print("/"); Serial.print( month ); Serial.print( "/" );Serial.println( dom );
}  


RealTimeClock::RealTimeClock()
{
    Wire.begin();
    Serial.println( "Initialised Wire" );

    // set the initial time here:
    // DS3231 seconds, minutes, hours, day, date, month, year
    this->second = 0;
    this->minute = 0;
    this->hour = 0;
    
    Serial.println( "Setting a dummy time (use during development only)" );
    setDS3231time(35,42,21,4,26,11,15);
    
    this->read();
}

