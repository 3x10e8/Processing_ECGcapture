import processing.serial.*;
 
Serial myPort;        // The serial port
//String inString;
PrintWriter output;

void setup () {
  //println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 115200); //check Device Manager to find the correct port (if using XDS110)
  myPort.bufferUntil('\n');
  output = createWriter("ecg.txt");
}

void draw(){
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  output.println(millis() + "\t" + inString);
  if (millis() > 10*60*1000) {
     output.flush();
     output.close();
     exit();
  }
}