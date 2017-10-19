class Slider { //slider method 
  int x, y, w, h, sliderX, sliderY, sliderW;
  float min, max;
  float value;
  boolean moving = false;
  String label;
  Slider(int x, int y, int w, int h, float min, float max, int init) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.sliderX = x;
    this.sliderY = y;
    this.sliderW = w/10;
    this.min = min;
    this.max = max;
    sliderX = sliderX + init;
    label = "";
  } 
  void draw() {
    fill(21, 101, 192);//draw slider
    rect(x, y, w, h);
    fill(21, 187, 192);
    rect(sliderX, sliderY, sliderW, h);
    textSize(10);
    fill(255);
    text(value, x, y-2);
    text(label, x+w/2-textWidth(label)/2, y+h/2+5/2);
  }
  void upDate() { //update slider with mouse location
    if (mouseY < y + h && mouseY > y && mouseX < x+w && mouseX > x-sliderW/2 && mousePressed) {
      moving = true;
    } else {
      moving = false;
    }
    if (moving) {
      sliderX = mouseX-sliderW/2;
    }
    value = map((float) sliderX/w, 0, 1, min, max);//map slider with value

    //println(value);
    draw();
  }
}