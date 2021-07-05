void setup() {
  size(1024, 768);
  noStroke();
  fill(255, 255);
  //初始化
  init();
}

void draw() {
  handleGameStart(); //from GameView
  if(timeLeft < 0){//from GameView
    background(0);
    timeLeft = 0;//from GameView
    handleGameEnd(); //from EndView
  }
}

void init(){
  //from GameView
  //設定開始時間
  timeStart = millis();
  //重置分數
  score = 0;
  //重置內容
  polygonList.clear();
}
