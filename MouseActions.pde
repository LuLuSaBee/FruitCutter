void mousePressed() {
  if(timeLeft == -1){//from FruitCutter
    print("notyet");
    /* do start view*/
  }else if(timeLeft == 0){//from FruitCutter
    if(isOverRestart) {//from EndView
      isOverRestart = false;
      init(); //from FruitCutter
      handleGameStart(); //from GameView
    }else if(isOverExit) {//from EndView
      isOverExit = false;
      exit(); 
    }
  }
}

boolean overButton(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
