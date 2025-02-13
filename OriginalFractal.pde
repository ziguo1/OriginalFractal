final int MIN_LENGTH = 9;
final color BG_COLOR = color(64, 64, 64);
color FILL_COLOR = color(255, 255, 255);

float osX = 0, osY = 0, zoom = 1, actualZoom = 1, aOsX = 0, aOsY = 0;
float pmX = 0, pmY = 0, time = 0;

float breathingAmount = 127;

void square(float x, float y, float length) {
  rect(x, y, length, length);
}

void setup() {
  size(512, 512);
  osX = -width * 2;
  //osY = -height;
}

void draw() {
  actualZoom = lerp(actualZoom, zoom, 0.1);
  aOsX = lerp(aOsX, osX, 0.2);
  aOsY = lerp(aOsY, osY, 0.2);

  translate(aOsX, aOsY);
  scale(actualZoom);

  FILL_COLOR = color(sin(time) * breathingAmount + breathingAmount,
    sin(time + 0.5) * breathingAmount + breathingAmount,
    sin(time + 1.0) * breathingAmount + breathingAmount);
  time += 0.005;

  background(BG_COLOR);
  noStroke();
  drawFractal(width, 0, width * 1, true);
  drawFractal(width * 2, 0, width * 1, true);
  drawFractal(width, height, width * 1, true);
  drawFractal(width * 2, height, width * 1, true);
}

void mousePressed() {
  pmX = mouseX;
  pmY = mouseY;
}

void mouseDragged() {
  osX += mouseX - pmX;
  osY += mouseY - pmY;
  pmX = mouseX;
  pmY = mouseY;
}

void keyPressed() {
  if (key == 'i') {
    zoom += 0.2;
  } else if (key == 'o') {
    zoom -= 0.2;
  }
  zoom = constrain(zoom, 0.5, 10);
}

void drawFractal(int x, int y, int length, boolean alt) {
  if (length < MIN_LENGTH) {
    return;
  } else {
    int newLength = length / 2;
    float sideLength = length * 1F/3F;

    fill(alt ? BG_COLOR : FILL_COLOR);
    square(x, y, sideLength);
    drawFractal(x, y, newLength, !alt);
    square(x + 2 * sideLength, y, sideLength);
    drawFractal((int) (x + 2 * sideLength), y, newLength, !alt);
    square(x + sideLength, y + sideLength, sideLength);
    drawFractal((int) (x + sideLength), (int) (y + sideLength), newLength, !alt);
    square(x, y + 2 * sideLength, sideLength);
    drawFractal(x, (int) (y + 2 * sideLength), newLength, !alt);
    square(x + 2 * sideLength, y + 2 * sideLength, sideLength);
    drawFractal((int) (x + 2 * sideLength), (int) (y + 2 * sideLength), newLength, !alt);
  }
}
