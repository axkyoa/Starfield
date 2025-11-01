Particle[] particles = new Particle[400];  
 float shipX = 0;
 float shipY = 150;
float angle = 0;

void setup() {
  size(900, 600);
  background(0);
  
  for (int i = 0; i < particles.length; i++) {
    if (i == 0) {
      particles[i] = new OddballParticle();  // first star = oddball
    } else {
      particles[i] = new Particle();
    }
  }
}

void draw() {
  background(0);
  translate(width/2, height/2); 

  for (int i = 0; i < particles.length; i++) {
    particles[i].move();
    particles[i].show();
  }

 float targetX = mouseX - width/2;
  float targetY = mouseY - height/2 + 150; // offset so ship stays lower
  shipX = lerp(shipX, targetX, 0.05);
  shipY = lerp(shipY, targetY, 0.05);

  angle = atan2(targetY - shipY, targetX - shipX);
  pushMatrix();
  translate(shipX, shipY);
  rotate(angle * 0.2); // small rotation for smooth tracking
  scale(1.5);
  drawShipAndYoda();
  popMatrix();
}

class Particle {
  double x, y, z;
  double speed;
  color c;

  Particle() {
    reset();
    c = color(random(150, 255));
  }

  void reset() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    speed = random(5, 20);
  }

  void move() {
    z -= speed;
    if (z < 1) {
      reset();
    }
  }

  void show() {
    fill(c);
    noStroke();
    float sx = (float)(x / z * width);
    float sy = (float)(y / z * height);
    float r = (float)(map((float)z, 0, width, 5, 0));
    ellipse(sx, sy, r, r);
  }
}


class OddballParticle extends Particle {
  OddballParticle() {
    super();
    c = color(255, 0, 0);
    speed = 25;
  }

  void show() {
    fill(c);
    stroke(255);
    strokeWeight(2);
    float sx = (float)(x / z * width);
    float sy = (float)(y / z * height);
    float r = (float)(map((float)z, 0, width, 20, 0));
    ellipse(sx, sy, r, r);
  }
}


void drawShipAndYoda() {
  
  fill(180);
  stroke(255);
  strokeWeight(2);
  ellipse(0, 0, 120, 60); // main saucer
  
  
  fill(0, 100, 255, 200);
  ellipse(0, -10, 60, 30);
  
  
  fill(50, 255, 50);
  ellipse(0, -15, 25, 25);
  
 
  triangle(-25, -20, -10, -15, -25, -10);
  triangle(25, -20, 10, -15, 25, -10);
  
  
  noStroke();
  fill(255, 0, 0);
  ellipse(-40, 10, 10, 10);
  fill(0, 255, 0);
  ellipse(40, 10, 10, 10);
  

  fill(0, 0, 255, 120);
  ellipse(0, 25, 40, 10);
}
