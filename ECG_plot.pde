// Use this for graphing values received over serial (backchannel UART), and then writing those to a file.

// This code has been adapted from the following sources:
// Arduino Graph Tutorial: 
//    https://www.arduino.cc/en/Tutorial/Graph
// SparkFun's ECG plotting: 
//    https://github.com/sparkfun/AD8232_Heart_Rate_Monitor/blob/master/Software/Heart_Rate_Display_Processing/Heart_Rate_Display/Heart_Rate_Display.pde
// Whandall's code on the Arduino forums:
//    https://forum.arduino.cc/index.php?topic=351828.0]
// linked on Processing's forums:
//    https://forum.processing.org/two/discussion/12274/mapping-error-arduino-very-basic

import processing.serial.*;
 
Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
 
float fValue;
float height_old = 0;
PrintWriter output;
boolean newVal = false;
 
void setup () {
  size(1040, 240);
 
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600); //check Device Manager to find the correct port (if using XDS110)
  myPort.bufferUntil('\n');
  background(0);
  stroke(127, 34, 255);
  output = createWriter("ecg.txt");
}
 
void draw () {
  if (newVal) {
    line(xPos, height_old, xPos, height - fValue);
    output.println(fValue);
    if (++xPos >= width) {
      xPos = 0;
      background(0);
    }
    newVal = false;
    height_old = height - fValue;
  }
}
 
void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    fValue = float(inString);
    fValue = map(fValue, 0, 1023, 0, height);
    newVal = true;
  }
}

void keyPressed(){
 output.flush();
 output.close();
 exit();
}