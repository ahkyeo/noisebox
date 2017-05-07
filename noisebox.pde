import pitaru.sonia_v2_9.*;
import krister.Ess.*;
AudioChannel myCh1, myCh2, myCh3, myCh4, myCh5, myCh6, myCh7, myCh8, myCh9;
AudioStream Str1;
AudioInput Inp1;
Reverb Rev1;
PinkNoise pNoise, pNoise1;
SawtoothWave sw1, sw2;
SineWave si1;
TriangleWave tw0, tw1, tw2, tw3;
PitchShift Ps1, Ps2;
Reverse Re1;

Sample myS1, myS2; 
float[] data; 

boolean inputReady=false;
float[] streamBuffer;

void setup() {
  size(600,600);
  Ess.start(this);

  myCh1 = new AudioChannel(Ess.MIX);
  myCh1.initChannel(myCh1.frames(35000));
  myCh1.softClip=true;
  pNoise =new PinkNoise(111);
  pNoise.generate(myCh1,0,myCh1.frames(35000));


  myCh2 = new AudioChannel(Ess.MIX);
  myCh2.initChannel(myCh2.frames(35000));
  myCh2.softClip=true;
  sw1 = new SawtoothWave(25,49);
  sw1.generate(myCh2,0,myCh2.frames(35000));


  myCh3 = new AudioChannel(Ess.MIX);
  myCh3.initChannel(myCh3.frames(35000));
  myCh3.softClip=true;
  sw2 = new SawtoothWave(30,77);
  sw2.generate(myCh3,0,myCh3.frames(35000));

  myCh4 = new AudioChannel(Ess.MIX);
  myCh4.initChannel(myCh4.frames(35000));
  myCh4.softClip=false;
  pNoise1 =new PinkNoise(75);
  pNoise1.generate(myCh4,0,myCh4.frames(35000));

  myCh5 = new AudioChannel();
  myCh5.initChannel(myCh5.frames(35000));
  tw0 = new TriangleWave(180,44);
  tw0.generate(myCh5,0,myCh5.frames(35000));

  myCh6 = new AudioChannel();
  myCh6.initChannel(myCh6.frames(35000));
  si1=new SineWave(90,10);
  si1.generate(myCh6,0,myCh6.frames(35000));

  myCh7 = new AudioChannel();
  myCh7.initChannel(myCh7.frames(5000));
  tw1=new TriangleWave(320,44);
  tw1.generate(myCh7,0,myCh7.frames(35000));

  myCh8 = new AudioChannel();
  myCh8.initChannel(myCh8.frames(5000));
  tw2=new TriangleWave(99,100);
  tw2.generate(myCh8,0,myCh8.frames(3000));

  myCh9 = new AudioChannel();
  myCh9.initChannel(myCh9.frames(35000));
  tw3=new TriangleWave(133,26);
  tw3.generate(myCh9,0,myCh9.frames(35000));

  Inp1=new AudioInput(); 
  Str1=new AudioStream(Inp1.size);
  streamBuffer=new float[Inp1.size];
  Inp1.start();
  Str1.start();

  Str1=new AudioStream();

//  Ps1=new PitchShift(Ess.calcShift(15));
//  Ps2=new PitchShift(Ess.calcShift(3));

//  Rev1=new Reverb();
//  Re1=new Reverse();

  myCh1.volume(0);
  myCh2.volume(0);
  myCh3.volume(0);
  myCh4.volume(0);
  myCh5.volume(0);
  myCh6.volume(0);
  myCh7.volume(0);
  myCh8.volume(0);
  myCh9.volume(0);
  myCh1.fadeTo(.5,500);
  myCh2.fadeTo(.5,500);
  myCh3.fadeTo(.5,500);
  myCh4.fadeTo(.5,500);
  myCh5.fadeTo(.5,500);
  myCh6.fadeTo(.5,500);
  myCh7.fadeTo(.5,500);
  myCh8.fadeTo(.5,500);
  myCh9.fadeTo(.5,500);

  Sonia.start(this); 
  myS1 = new Sample(10000,44100,2); // create an empty STEREO sample, at 44100 sampling rate. 
  myS2 = new Sample(10000,44100,2); // create an empty STEREO sample, at 44100 sampling rate. 
  data = new float[10000]; // create an array with the same length of the sample's channel. 

  // Populate the array with sample data, a sin wave in this case 
  for(int i = 0; i < 1024; i++){ 
    float oneCycle = TWO_PI/1024; 
    int freq = 10;    
    data[i] = sin(i*oneCycle*freq); 
  } 


  frameRate(30);

  noFill();
  smooth();
  ellipseMode(CENTER);

}

void draw() {

  background(66, 66, 66);
  strokeWeight(1);
  stroke(255);

  int tx=mouseX;
  int ty=mouseY;

  float newPan=1-(tx/float(width))*2;
  float newVolume=1-ty/float(height);

  if (!myCh1.panning) myCh1.panTo(newPan,500);
  if (!myCh2.panning) myCh2.panTo(-newPan,500);
  if (!myCh3.panning) myCh3.panTo(newPan,500);
  if (!myCh4.panning) myCh4.panTo(-newPan,500);
  if (!myCh5.panning) myCh5.panTo(newPan,500);
  if (!myCh6.panning) myCh6.panTo(-newPan,500);
  if (!myCh7.panning) myCh7.panTo(newPan,500);
  if (!myCh8.panning) myCh8.panTo(-newPan,500);
  if (!myCh9.panning) myCh9.panTo(newPan,500);

  line(tx,0,tx,height);
  line(width-tx,0,width-tx,height);

  if (!myCh1.fading) myCh1.fadeTo(newVolume,500);
  if (!myCh2.fading) myCh2.fadeTo(-newVolume,500);
  if (!myCh3.fading) myCh3.fadeTo(newVolume,500);
  if (!myCh4.fading) myCh4.fadeTo(-newVolume,500);
  if (!myCh5.fading) myCh5.fadeTo(newVolume,500);
  if (!myCh6.fading) myCh6.fadeTo(-newVolume,500);
  if (!myCh7.fading) myCh7.fadeTo(newVolume,500);
  if (!myCh8.fading) myCh8.fadeTo(-newVolume,500);
  if (!myCh9.fading) myCh9.fadeTo(newVolume,500);

  line(0,ty,width,ty);
  line(0,height-ty,width,height-ty);

  int d=((millis()/75) % 20)+4;

  strokeWeight(3);
  stroke(255,255-d*(255/20));

  ellipse(tx,ty,d,d);
  ellipse(width-tx,height-ty,d,d);

}

/* void audioStreamWrite(AudioStream theStream) {
  while (!inputReady); 
  System.arraycopy(streamBuffer,0,Str1.buffer,0,streamBuffer.length);
  inputReady=false;
}

void audioInputData(AudioInput theInput) {
  System.arraycopy(Inp1.buffer,0,streamBuffer,0,Inp1.size);
  inputReady=true;
}
*/


void keyPressed() {
  if (key == '7') {
    myCh1.play();
    myS1.writeChannel(0, data); 
  } 
  else {

  }
  if (key == '8') {
    myCh2.play();
    myS2.writeChannel(0, data); 
  } 
  else {

  }
  if (key == '9') {
    myCh3.play();
    myS1.writeChannel(0, data); 
  } 
  else {

  }
  if (key == '6') {
    myCh4.play();
    myS2.writeChannel(0, data); 
  } 
  else {

  }
  if (key == '5') {
    myCh5.play();
    myS2.writeChannel(0, data); 
  } 
  else {

  }
  if (key == '4') {
    myCh6.play();
    myS2.writeChannel(0, data); 
  } 
  else {

  }
  if (key == '3') {
    myCh7.play();
    myS1.writeChannel(0, data); 
  } 
  else {

  }
  if (key == '2') {
    myCh8.play();
    myS2.writeChannel(0, data); 
  } 
  else {

  }
  if (key == '1') {
    myCh9.play();
    myS1.writeChannel(0, data); 
  } 
  else {

  }
  if (keyCode == SHIFT) {
    Str1.pan(random(2)-1);
    println(Str1.pan);
  }
  else {
  }
/*  if (key == 'q') {
    //    Ps1.filter(Str1);
    Str1.setSpeed(55);
  }
  else {
  }
  if (key == 'a') {
    //    Ps2.filter(Str1);
    Str1.setSpeed(22);
  }
  else {
  }
  if (key == 'z') {
    //    Re1.filter(Str1,0,Str1.frames(1000));
  }
  else {
  }
  */

}
