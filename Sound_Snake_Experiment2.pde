import processing.serial.*;
Serial myPort;
// Ben DeSouza
// 05/03/18
// Snake
// My first attempt in making a basic 'Snake' game on Processing

ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
//Determines starting position of the snake
int w = 30, h = 30, bs = 20, dir = 2, applex = 12, appley = 10; 
//Determines the size of the board and creates 'apple' variable
int[] snakex = {0,0,1,-1}, snakey = {1,-1,0,0}; 
//The Snake's avaialable movements on the X & Y axis'
boolean gameover = false; //Creating a reference for a 'Game Over' scenario
int newdir;

void setup(){
  size(600,600); //size(Width,Height);
  x.add(5); //Snake starting position on the X axis
  y.add(5); //Snake starting position on the Y axis
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil(',');
}

void draw(){
  background(25, 0, 255); //background(Red, Green, Blue);
  for(int i = 0 ; i < w; i++) line(i*bs, 0, i*bs, height); //Generates vertical lines on the board
  for(int i = 0 ; i < h; i++) line(0, i*bs, width, i*bs); //Generates horizontal line on the board
  for(int i = 0 ; i < x.size(); i++) { //The snake body itself
     fill(0,255,0); //The colour of the Snake
     rect(x.get(i)*bs, y.get(i)*bs, bs, bs); //The shapes the snake is formed of
  }
  if(!gameover) {
  fill(255,0,0); //The colour of the Apple
  rect(applex*bs, appley*bs, bs, bs); //The shape the apple is formed of
  if(frameCount%5==0) {
    x.add(0,x.get(0) + snakex[dir]);
    y.add(0,y.get(0) + snakey[dir]);
    
    if (x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h) gameover = true;
    //If the snake hits the walls then 'Game Over!'
    for(int i = 1; i < x.size(); i++) if(x.get(0)==x.get(i) && y.get(0) == y.get(i)) gameover =true;
    //If the snake hits the itself then 'Game Over!"
    
    if(x.get(0)==applex && y.get(0)==appley) {
      applex = (int)random(0,w); //Generates apple in new location when eaten
      appley = (int)random(0,h); //Generates apple in new location when eaten
    
  }else { //Increases length of Snake when apple is eaten 
    x.remove(x.size()-1);
    y.remove(y.size()-1);//Enables the Snake to move on it's own
  }
  }
  }else { //Deciding what happens when 'Game Over' occurs
    fill(0);
    textAlign(CENTER);
    textSize(30);
    text("YOU LOSE! Press Space", width/2, height); //Make a text with instructions
    if(keyPressed&&key==' ') {
      x.clear();
      y.clear();
      x.add(5);
      y.add(5);
      gameover = false; //Resets the game to the original variables
}}}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil(',');
  String items[] = split(inString, ':');
  if (items.length > 1) {
    String label = trim(items[0]);
    String val = split(items[1], ',')[0];
    println(val);
    if (label.equals("S")) {
     
      if (float(val) > 1.0){
        println("S");
        newdir= 0;
        checksnake();
      }
    }
  }
}

void checksnake(){
 if(newdir != -1 && (x.size() <= 1 ||!(x.get(1)==x.get(0)+snakex[newdir] && y.get(1)==y.get(0)+snakey[newdir]))) dir = newdir; 
} //So the Snake can't go back into itself


void keyPressed() {

  newdir=-1;
  
  switch (key){
   
    case 'S' :
    newdir=0;
    break;
    case 'W' :
    newdir=1;
    break;
    case 'D' :
    newdir=2;
    break;
    case 'A' :
    newdir=3;
    break;
    case 's' :
    newdir=0;
    break;
    case 'w' :
    newdir=1;
    break;
    case 'd' :
    newdir=2;
    break;
    case 'a' :
    newdir=3;
    break;
    }
  //The controls: S= Down, W= Up, D=Right, A=Left
  
  //int newdir = key=='S' ? 0 : (key=='W' ? 1 : (key=='D' ? 2 : (key=='A' ? 3 : -1)));
  
  checksnake();
  //if(newdir != -1 && (x.size() <= 1 ||!(x.get(1)==x.get(0)+snakex[newdir] && y.get(1)==y.get(0)+snakey[newdir]))) dir = newdir;
  //So the Snake can't go back into itself
}