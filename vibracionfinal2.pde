
float l1 = 150;
float l2 = 150;
float r1_v = 0;
float r1_a = 0;
float r2_v = 0;
float r2_a = 0;

float a1 = PI/2;
float a1_v = 0;
float a1_a = 0;
float a2 = PI/2;
float a2_v = 0;
float a2_a = 0;

float m1 = 50;
float m2 = 50;

float u1 = 5;
float u2 = 5;
float r1 = u1 + l1;
float r2 = u2 + l2;

float g = 1; //gravitational constant (realistic value not considered for simplicity )
float k1 = 0.5; //constante de elasticidad
float k2 = 0.5; //constante de elasticidad

float px1 = -1; // previous position of second pendulum sphere - x offset
float py1= -1;
float px2 = -1; // previous position of second pendulum sphere - x offset
float py2= -1;
float cx, cy; //centre of x and y for background

PGraphics canvas; // canvas is just a variable name DO NOT CONFUSE IT WITH P5.JS

void setup() {
  size(900, 600);
  cx = width/2;
  cy = 100;
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}

void draw() {
  background(255);
  imageMode(CORNER);
  image(canvas, 0, 0, width, height);
  // numerators are moduled

  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1-2*a2);
  float num3 = -2*sin(a1-a2)*m2;
  float num4 = a2_v*a2_v*r2+a1_v*a1_v*l1*cos(a1-a2);
  float den = l1 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a1_a = (num1 + num2 + num3*num4) / den;

  num1 = 2 * sin(a1-a2);
  num2 = (a1_v*a1_v*l1*(m1+m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v*a2_v*r2*m2*cos(a1-a2);
  den = l2 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a2_a = (num1*(num2+num3+num4)) / den;




  float r1_a = -k1/m1*(r1-l1);

  float r2_a = -k1/m1*(r2-r1);

  translate(cx, cy);
  stroke(0);
  strokeWeight(2);



  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);

  float x2 = x1+r2 * sin(a2);
  float y2 = y1+r2 * cos(a2);



  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, m1, m1);
  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, m2, m2);


  a1_v += a1_a;
  a1 += a1_v;
  a1_v *= 0.995;

  r1_v += r1_a;
  r1 += r1_v;
  r1_v *=0.995;

  a2_v += a2_a;
  a2 += a2_v;
  a2_v *= 0.995;

  r2_v += r2_a;
  r2 += r2_v;
  r2_v *=0.995;

  canvas.beginDraw();
  //canvas.background(0, 1);
  canvas.translate(cx, cy);
  canvas.stroke(0);
  if (frameCount > 1) {
    canvas.line(px1, py1, x1, y1);
    canvas.line(px2, py2, x2, y2);
  }
  canvas.endDraw();
  px1 = x1;
  py1 = y1;

  px2 = x2;
  py2 = y2;
}
