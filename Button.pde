class Button {
  int x, y, w, h, buttonX, buttonY, buttonW;
  String label;
  boolean clicked = false;
  Button(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    buttonX = x;
    buttonY = y;
    buttonW = w/10;
    label = "";
  }
  void draw() {
    if (clicked) {
      fill(21, 187, 192);
    } else {
      fill(21, 101, 192);
    }
    rect(buttonX, buttonY, w, h);
    textSize(10);
    fill(255);
    text(label, x+w/2-textWidth(label)/2, y+h/2+5/2);
  }
  void upDate() { //update slider with mouse location
    if (mouseY < y + h && mouseY > y && mouseX < x+w && mouseX > x-buttonW/2 ) {
      if (mousePressed) {
        clicked = true;
        Reset();
      }
    } else {
      clicked = false;
    }
    //println(value);
    draw();
  }
}