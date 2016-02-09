# Processing_ECGcapture
Code for making plots of serially captured data using Processing 3. This also writes the data out to a .txt file.
This is adapted from examples found over different forums (see code for links). 

I couldn't quite get the draw() functions to work initially, but this should work now.

The idea is that whenever a new serial packet is received, we extract the numbers to be plotted from it.
Next, there is a boolean variable which is switched so that a plotting routine (called draw) can kick in.
Finally, pressing any key on the keyboard should stop the plotting and write the text file out.

Note: this flushing on pressing a key has given me problems. 
So, I have included a printOnly file which just captures serial data for a pre-alloted amount of time.
Then, it flushes on its own and exits. I find this to be more reliable than writing to the txt file's buffer while plotting.

Any fixes will be appreciated!

Also, some ECG data is included, which was captured using this code from serial data being outputted by an MSP432 connected to an AD8232.
The MSP432 code is here:
https://github.com/3x10e8/analog_multiTask
