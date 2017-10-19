class Person {
  PVector X;
  PVector V, Vi;
  float rad;
  int fillColor;
  boolean infected, dead;
  float time1, time2;
  Person() {
    X = new PVector(0, 0);
    V = new PVector(0, 0);
    Vi = new PVector(random(-3, 3), random(-3, 3));
    rad = 4;
    fillColor = color(0);
    dead = false;
    infected = false;
  }
  void draw() {
    if (infected && !dead) {//draw different colors for different states 
      time2 = millis();
      fill(255, 0, 0);
    } else if (dead) {
      V = new PVector(0, 0);
      fill(255, 90);
    } else {
      fill(9, 99, 9);
      V = Vi;
    }
    noStroke();
    ellipseMode(RADIUS);
    ellipse(X.x, X.y, rad, rad);//draw person
  }
  void update() {
    if (!infected) {
      time2 = millis();
      time1 = millis();
    }
    if (((time2-time1)/1000) > daysAlive && !dead) {//if they are alive past the allowed time, kill them
      dead = true;
      deadCount ++;//increase death tally by one and decrease infected count by one
      infectedCount --;
      if (infectedCount == 0) {//if there is not infected people then virus has been elimiated from population 
        noVirus = t2/1000;//record time for use in message
      }
      //infected = false;
    }
    //update positions of persons using velocity vector
    X.add(V);
    if (!dead){
      if (X.x > width-rad) {//if it is greater than width switch velocity in X direction
        X.x = width-rad;
        V.x = -V.x;
      }
      if (X.y > height-rad) {//if it is greater than height switch velocity in Y direction
        X.y = height-rad;
        V.y = -V.y;
      }
      if (X.x < rad) {//if it hits the left slide then switch velocity
        X.x = rad;
        V.x = -V.x;
      }
      if (X.y < rad) {//if it hits the top then switch velocity
        X.y = rad;
        V.y = -V.y;
      }
    }
  }
  void infect() {//infect the person 
    infected = true;
    time1 = millis();//get the time when they are infected (to kill them later)
    infectedCount ++;//increase the infected count by one
  }
  void reset(){
    this.infected = false;
    this.dead = false;
    this.V = new PVector(random(-3, 3), random(-3, 3));
    this.X = new PVector(random(0, width), random(0, height));
  }
}