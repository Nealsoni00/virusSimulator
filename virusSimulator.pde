Slider life, iStrength;
Button reset;

Person[] People;

int numPersons;
float daysAlive, infectionStrength;
int infectedCount = 1;
int deadCount = 0; 
int graphLength;
int graphHeight = height;
int graphGap = 10;

float noVirus;
float t1, t2;

ArrayList<Points> healthyPoints = new ArrayList();
ArrayList<Points> infectedPoints = new ArrayList();
ArrayList<Points> deadPoints = new ArrayList();

void setup() {
  size (1800, 900);
  graphLength = width/3;
  graphHeight = height/7;
  background(255);
  reset = new Button(10, 90, 100, 19); //(10,10)
  reset.label = "Reset";

  life = new Slider(10, 10, 100, 19, 1, 30, 20);
  life.label = "Days Before Death";

  iStrength = new Slider(10, 50, 100, 19, 1, 20, 30);
  iStrength.label = "Transmission Rate";
  //people = new ArrayList<Person>();
  numPersons = 5000;
  People = new Person[numPersons];
  for ( int i = 0; i<numPersons; i++) {//create 1000 people with random position and velocities
    Person p = new Person();
    p.X.x = random(width);
    p.X.y = random(height);
    p.V.x = random(-3, 3);
    p.V.y = random(-3, 3);
    People[i] = p;
    if (int(random(0,10)) == 9){
      p.imune = true;
    }else{
      p.imune = false;
    }
  }
  People[1].infected = true;//INFECT THE FIRST PERSON
  t1 = millis();
  iStrength.value = 5.00;
}

void draw() {
  //println(t2/1000, numPersons-infectedCount-deadCount, infectedCount, deadCount);
  background(0);
  daysAlive = life.value;
  infectionStrength = iStrength.value;
  for ( int i = 0; i<numPersons; i++) {//update every person and draw them
    People[i].update();
    People[i].draw();
    if (People[i].infected && !People[i].dead) {//only do this if the person is infected
      for (int j = 0; j < numPersons; j++) { 
        if (!People[j].infected) {
          if (collide(People[i].X, People[j].X)) {//infect new people if they collide and are not dead or infected
            if (!People[j].imune){
              People[j].infect();
            }else{
              People[j].imuneShown = true;
            }
          }
        }
      }
    }
  }
  upDateSliders();
  t2 = millis()-t1;
  drawGraphs();
  drawText();
}
void upDateSliders() {
  life.upDate();
  iStrength.upDate();
  reset.upDate();
  life.draw();
  iStrength.draw();
  reset.draw();
}

void drawText(){
  fill(0);
  textSize(15);
  fill(255);
  //displays stats:
  fill(255);
  text("Days: " + t2/1000, width/6, 25);
  text("There are " + (numPersons-infectedCount-deadCount) + " Healthy People", width/2-150, 25);
  text((infectedCount) + " Infected People", width/2-75, 50);
  text((deadCount) + " Dead People", width/2-75, 75);
  if (infectedCount == 0) {
    if (deadCount == 1000) {
      text("Everyone is dead after " + noVirus + " Days", width/2-150, height/2);
    } else {
      text("Virus eliminated after " + noVirus + " Days", width/2-100, height/2);
    }
  }
}

boolean collide(PVector pos1, PVector pos2) {
  if (pos1.dist(pos2) < infectionStrength) {
    if (random(0,10) < 9){
      return true;
    }
  }
  return false;
  
}
//Button methods
public void Reset() {//the reset button initiates this method
  for ( int i = 0; i<numPersons; i++) {//uninfect everyone
    People[i].reset();
    if (int(random(0,10)) == 9){
      People[i].imune = true;
    }else{
      People[i].imune = false;
    }
  }
  
  People[0].infect();//infect the first person and give them new location and velocity
  t1 = millis();//reset time
  infectedCount = 1;//reset counting variables
  deadCount = 0;
}



void drawGraphs() {
  fill(255);

  //Start Graphing
  rect(width-graphLength-10, 10, graphLength, graphHeight);
  //GRAPH HEALTHY LINE
    
  strokeWeight(2);
  beginShape();
  stroke(0, 255, 0);
  for (int i=0; i<healthyPoints.size()-1; i++) {
    Points P = (Points)healthyPoints.get(i);
    Points P2 = (Points)healthyPoints.get(i);
    line(P.x, P.y,P2.x, P2.y);
    if (P.x < width-graphLength-10)healthyPoints.remove(i);
    P.x--;
  }
  endShape();

  //GRAPH INFECTED LINE
  beginShape();
  stroke(0, 0, 255);
  for (int i=0; i<deadPoints.size()-1; i++) {
     Points P = (Points)deadPoints.get(i);
     Points P2 = (Points)deadPoints.get(i);
     line(P.x, P.y,P2.x, P2.y);    
     if (P.x < width-graphLength-10)deadPoints.remove(i);
     P.x--;
  }
  endShape();

  //GRAPH INFECTED LINE
  beginShape();
  stroke(255, 0, 0);
  for (int i=0; i<infectedPoints.size()-1; i++) {
    Points P = (Points)infectedPoints.get(i);
    Points P2 = (Points)infectedPoints.get(i);
    line(P.x, P.y,P2.x, P2.y);   
    if (P.x < width-graphLength-10)infectedPoints.remove(i);
    P.x--;
  }
  endShape();
  //End Graphing
  fill(0);
  text("Graph of", width - (graphLength-10)/2-textWidth("Graph of Healthy, Infected, and Dead vs Time")/2 + 6, 25);
  fill(0, 255, 0);
  text("Healthy,", width - (graphLength-10)/2 - textWidth("Graph of Healthy, Infected")/2  + 6, 25);
  fill(255, 0, 0);
  text("Infected,", width - (graphLength-10)/2 - textWidth("Infected,")/2  + 6, 25);
  fill(0, 0, 255);
  text("and Dead", width - (graphLength-10)/2 + textWidth("and Dead")/2  + 6, 25);



  float healthy = map((numPersons-infectedCount-deadCount), 0, numPersons, 0, graphHeight);
  //println(healthy);
  float dead = map(deadCount, 0, numPersons, 0, graphHeight);
  float infected = map(infectedCount, 0, numPersons, 0, graphHeight);
  Points h = new Points(width - 10, graphHeight + graphGap - healthy);
  Points i = new Points(width - 10, graphHeight + graphGap - infected);
  Points d = new Points(width - 10, graphHeight + graphGap - dead);
  healthyPoints.add(h);
  infectedPoints.add(i);
  deadPoints.add(d);
}