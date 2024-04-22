#include <SoftwareSerial.h>
#define LED1        8
#define LED2        9
#define LED3        10
#define LOW         0
#define HIGH        1
#define received    1

// Create software serial object to communicate with SIM808
SoftwareSerial sim808(3, 2); // SIM808 Tx & Rx is connected to Arduino #3 & #2

int password_idx = 5;

char password[6];
char  command[2];
char  msg = 0;

void setup()
{
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);

  digitalWrite(LED1, LOW);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, LOW);

  sim808.begin(9600);
  Serial.begin(9600);
  Serial.println("Hello");
  delay(100);
}

void loop()
{ 
   sim808.println("AT+CMGR=1");
   updateSerial();

  // checking password 
  if(msg == received)
  {
    // Doing command
    switch(command[0])
    {
      case '0':
        digitalWrite(LED1, LOW);
        break;

      case '1':
        digitalWrite(LED1, HIGH);
        break;

      case '2':
        digitalWrite(LED2, LOW);
        break;

      case '3':
        digitalWrite(LED2, HIGH);
        break;

      case '4':
        digitalWrite(LED3, LOW);
        break;
    
      case '5':
        digitalWrite(LED3, HIGH);
        break;
    }
    msg = 0;
    // Deleting msg
    sim808.println("AT+CMGD=1");
  }
  
}

void updateSerial()
{
  delay(100);
  while (sim808.available())
  {
    String receivedMsg = sim808.readString();
    char lastIndex = receivedMsg.lastIndexOf('@');
    if (lastIndex > 1)
    {
      msg = received;
      String lastWord = receivedMsg.substring(lastIndex+1);
      char lastWordLength = lastWord.length();

      for(char i=0; i<lastWordLength ; i++)
      {
        if(i < password_idx)
        {
          password[i] = lastWord.charAt(i);
        }
        else
        {
          if(lastWord.charAt(i) == '/')
          {
          }
          else
          {
            command[0] = lastWord.charAt(i);
            break;
          }
        }
      }
    }
  }
  delay(1000);
  //Serial.println(password);
  //Serial.println(command);
}