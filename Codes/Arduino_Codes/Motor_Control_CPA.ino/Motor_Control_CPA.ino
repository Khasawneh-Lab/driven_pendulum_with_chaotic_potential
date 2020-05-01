// Design of Chaotic Pendulum with a Variable Interaction Potential
// Motor Control Arduino Code

// Determine the pins where DC motor is connected 
int in1 = 7; 
int in2 = 8; 
int ConA = 9; 

// import the step motor library
#include <Stepper.h>
// determine the step number 
const int stepsPerRevolution = 200;
// initialize the library for step motor which is connectted to pins 10-13
Stepper myStepper(stepsPerRevolution, 10, 11, 12, 13);

void setup() {
  
  //Define the pin modes
  pinMode(in1, OUTPUT); 
  pinMode(in2, OUTPUT);
  pinMode(ConA, OUTPUT);

  //turn DC motor 
  TurnMotorA();
  
  // set the speed of step motor at 30 rpm:
  myStepper.setSpeed(30);
  
  // initialize the serial port:
  Serial.begin(57600);
}

// Define a function for DC motor. Speed range is 0-255
void TurnMotorA(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  analogWrite(ConA,150);
  }

void loop() {
  TurnMotorA();  
  myStepper.step(stepsPerRevolution); 
}
