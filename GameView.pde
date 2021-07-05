import java.util.*;

//遊戲設定
float timeLimit = 30 ; //second 
int maxSpeed = 15;
int minSpeed = 5;
int maxPolygons = 6;
int maxBorder = 10;
float level = 2;

java.awt.Polygon polygonPoint = new java.awt.Polygon();
int mouse_stored = 10;
float mouse_x[] = new float[mouse_stored];
float mouse_y[] = new float[mouse_stored];
int timeStart; 
float timeLeft = -1;
int score = 0;
ArrayList<Polygon> polygonList = new ArrayList();
float maxXPersent = (1 - 0.05);
float minXPersent = 0.05;
float maxYPersent = (1 - 0.1);
float minYPersent = 0.2;
float maxSize = 0.1;
float minSize = 0.05;

class Polygon{
  boolean isDead = false, isUp = true;
  int border, speed;
  float x, y, size, maxY;
  color rgb;
  
  Polygon(
      int border, float x,float y,
      float size, color rgb,float maxY,int speed
  ){
    this.border = border;
    this.x = x;
    this.y = y;
    this.size = size;
    this.rgb = rgb;
    this.maxY = maxY;
    this.speed = -speed;
  }
}

void handleGameStart(){
  //設定背景
  background(51);
  //多邊形
  if(timeLeft > 0){
    makePolygon();
    handlePolygonAction();
  }
  //設定文字與刀顏色
  fill(255);
  //計算時間
  timeLeft = timeLimit * 1000 - (millis() - timeStart);
  //設定文字大小
  textSize(32);
  //顯示時間
  textAlign(LEFT, CENTER);
  text(String.format("Time Left: %.2f", timeLeft/1000), 20, 30);
  //顯示分數
  textAlign(RIGHT, CENTER);
  text(String.format("Score: %3d", score), width - 20, 30);
  //水果刀的刀
  fruitKnife();
}

void makePolygon(){
  int randomQuantity = (int)(Math.random() + 0.5);
  for(int i = 0; aliveCount() < maxPolygons && i < randomQuantity; i++){
    int border = (int)(Math.random()*(maxBorder + level - 3 + 1)) + 3;
    float x = (int)(((Math.random()*(maxXPersent*100 - minXPersent*100  + 1)) + minXPersent*100)/100 * width);
    float size = (int)(Math.random()*(width*maxSize - width*minSize + 1)) + 50;
    float r = (int)(Math.random()*(200 - 50 + 1)) + 50;
    float g = (int)(Math.random()*(200 - 50 + 1)) + 50;
    float b = (int)(Math.random()*(200 - 50 + 1)) + 50;
    float maxY = (int)(((Math.random()*(maxYPersent*100 - minYPersent*100  + 1)) + minYPersent*100)/100 * height);
    int speed = (int)(Math.random()*(maxSpeed - minSpeed + 1)) + minSpeed;
    if(border > maxBorder){
      border = 720;
      r = g = b = 0;
    }
    x = (x + size) >= width * maxXPersent ? x - size: x;
    x = (x - size) <= width * minXPersent ? x + size: x;
    polygonList.add(new Polygon(border, x, width, size, color(r, g, b), maxY, speed));
  }
}

void handlePolygonAction(){
  for(Polygon polygon: polygonList){
    if(polygon.isDead && polygon.y > width) continue;
    else if(polygon.y < polygon.maxY){ 
      polygon.speed *= -1;
      polygon.isUp = false;
    }
    else if(polygon.y > width) polygon.isDead = true;
    drawPolygon(polygon);
    polygon.y += polygon.speed;
  }
}

void drawPolygon(Polygon polygon) {
  float angle = TWO_PI / polygon.border;
  beginShape();
  fill(polygon.rgb);
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = polygon.x + cos(a) * polygon.size;
    float sy = polygon.y + sin(a) * polygon.size;
    vertex(sx, sy);
    if(!polygon.isDead){
      polygonPoint.addPoint((int)sx, (int)sy);
    }
  }
  endShape();
  if(polygonPoint.contains((int)mouseX, (int)mouseY)){
    polygon.isDead = true;
    polygon.rgb = color(220, 220, 220);
    score += (polygon.border <= maxBorder)? 1: -1;
  }
  polygonPoint.reset();
}

int aliveCount(){
  int count = 0;
  for(Polygon polygon: polygonList)
    if(!polygon.isDead) count++;
  return count;
}

/* fruit_knife (mouse) */
void fruitKnife(){
  int which = frameCount % mouse_stored;
  mouse_x[which] = mouseX;
  mouse_y[which] = mouseY;
  
  for (int i = 0; i < mouse_stored; i++) {
    int index = (which+1 + i) % mouse_stored;
    circle(mouse_x[index], mouse_y[index], i);
    int lastIndex = index - 1 == -1 ? mouse_stored - 1 : index - 1;
    float x_move = mouse_x[index] - mouse_x[lastIndex];
    float y_move = mouse_y[index] - mouse_y[lastIndex];
    int count = 1000;
    for(int j = 0; j < count; j++){
      circle(
        mouse_x[lastIndex] + (x_move/count)*j, 
        mouse_y[lastIndex] + (y_move/count)*j, 
        i + j/count
      );
    }
  }
}
