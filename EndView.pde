boolean isOverRestart = false;
boolean isOverExit = false;
int button_width = 200;
int button_height = 50;
int button_radius = 10;
int button_space = 70;

void handleGameEnd(){
  textAlign(CENTER, CENTER);
  
  /* 分數 */
  textSize(64);
  fill(255);
  text(String.format("Your score is %3d", score), width/2, height/2 - 100);
  
  /* 按鈕 */
  textSize(32);
  int button_x = width/2 - button_width/2;
  int button_y = height/2;
  /* 再玩一次 */
  fill(204, 102, 0);
  rect(button_x, button_y, button_width, button_height, button_radius);
  fill(255);
  text("Play Again",button_x, button_y, button_width, button_height);
  isOverRestart = overButton(button_x, button_y, button_width, button_height);
  
  /* 離開遊戲 */
  fill(191, 103, 102);
  rect(button_x, button_y + button_space, button_width, button_height, button_radius);
  fill(255);
  text("Exit",button_x, button_y + button_space, button_width, button_height);
  isOverExit = overButton(button_x, button_y + button_space, button_width, button_height);
}
