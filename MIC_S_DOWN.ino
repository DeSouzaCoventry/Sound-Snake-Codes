// Ben DeSouza
// 22/03/18
// Arduino Sound Experiment
// Testing whether the microphone in Arduino works

const int sampleWindow = 50; // Sample window width in mS (50 mS = 20Hz)
unsigned int sample;

void setup() 
{
   Serial.begin(9600);
}


void loop() 
{
   unsigned long startMillis= millis();  // Start of sample window
   unsigned int peakToPeak = 0;   // peak-to-peak level

   unsigned int signalMax = 0;
   unsigned int signalMin = 1024;

   // collect data for 50 mS
   while (millis() - startMillis < sampleWindow)
   {
      sample = analogRead(A0); //Port of the mic
      if (sample < 1024)  // Tosses out spurious readings
      {
         if (sample > signalMax)
         {
            signalMax = sample;  // Save just the max levels
         }
         else if (sample < signalMin)
         {
            signalMin = sample;  // save just the min levels
         } 
      }
   }
   peakToPeak = signalMax - signalMin;  // max - min = peak-peak amplitude
   double volts = (peakToPeak * 3.3) / 1024;  // convert to volts

  // Serial.println(volts);

  Serial.print("S:");
  Serial.print(volts); //When the sound signal is recieved, produce an 'S'
  Serial.print(","); //Repeat block of code for the other controls and other mics
  

 
 
 }
