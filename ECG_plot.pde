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
int xPos = 1;         // stores horizontal index (x value) for the points being plotted
 
float fValue; // stores serial data
float height_old = 0; // used in plotting
PrintWriter output; // used for writing out data to txt file
boolean newVal = false; // used for updating plot with new captures
 
void setup () {
  size(1040, 240); // size of plot window
 
  println(Serial.list()); // use for identifying the correct COM port. Once identified, index as seen in the next line
  myPort = new Serial(this, Serial.list()[1], 9600); //check Device Manager to find the correct port (if using XDS110)
  myPort.bufferUntil('\n');
  background(0);
  stroke(127, 34, 255); // color of the "strokes" used for plotting the data
  output = createWriter("ecg.txt"); // change name of output file as needed
}
 
void draw () { // used to draw a new stroke corresponding to data reads from the serialEvent below
  if (newVal) {
    line(xPos, height_old, xPos, height - fValue); // linear interpolation
    output.println(fValue); // use for monitoring the captured values in console. Can comment out too.
    if (++xPos >= width) {
      xPos = 0; // start over from the left extreme
      background(0);
    }
    newVal = false; // will be updated again by serialEvent
    height_old = height - fValue;
  }
}
 
void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString); // remove white space
    fValue = float(inString); // cast as float
    fValue = map(fValue, 0, 1023, 0, height); // map values to plot axes
    newVal = true; // would allow draw() to run
  }
}

void keyPressed(){ // press any key to flush the buffer (write out the txt file). This may fail. Use printOnly code.
 output.flush();
 output.close();
 exit();
}