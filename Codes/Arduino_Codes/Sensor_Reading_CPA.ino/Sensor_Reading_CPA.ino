// Design of Chaotic Pendulum with a Variable Interaction Potential
// Sensor Reading Arduino Code

//Determinet the pins for rotary encoder (2-3) and photogater sensor (6)
int encoder_a = 2;
int encoder_b = 3;
int sensorPin = 6;  
int sensorValue = LOW; 

//determine the variables used in the code
float counter = 0;
float degree;
double absolute_degree;
int speedd;
int division;
char pos[5];
unsigned long time;

void setup()
{

// initalize serial port
Serial.begin(2000000);

// types of pins for rotary encoder and photogate sensor
pinMode(2, INPUT_PULLUP); 
pinMode(3, INPUT_PULLUP); 
pinMode(sensorPin, INPUT_PULLUP);

// determine the attachInterrupt pins
counter = 0; 
attachInterrupt(digitalPinToInterrupt(2),encoder_kesme_a,RISING);
counter = 0;
attachInterrupt(digitalPinToInterrupt(3),encoder_kesme_b,RISING);
counter = 0;

Serial.println(counter);
}
void loop()
{
time = micros();
//degree = (counter/(8000/360));
//if (counter>=0){
//  division = (counter/(8000/360))/360;
//  degree = (counter/(8000/360))-(360*division);
//}
//else{
//  division = (counter/(8000/360))/360;
//  degree = 360+(counter/(8000/360))-(360*division);
//  }
//if (int(counter/20000)!=0){
//  counter=0;
//  }
//degree = (counter/(20000/360));
//if (int((counter/(8000/360))/180)>0){
//  
//}

// reads and prints the sensor and counter values
sensorValue = digitalRead(sensorPin); 
Serial.print(sensorValue);
Serial.print(","); 
Serial.println(counter,4);
}

// attachInterrupt function for a and b pins of the rotary sensor
void encoder_kesme_a()
{
if(digitalRead(3) == HIGH) {
counter++;
}else{
counter--;
}
}

void encoder_kesme_b()
{
if(digitalRead(2) == HIGH) {
counter--;
}else{
counter++;
}
}
