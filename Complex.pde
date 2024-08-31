public class Complex {
  public float real;
  public float imaginary;
  public float radius;
  public float theta;
  public color fillColor = color(0, 0, 255);
  public final static int minSize = 5;
  public final static int maxSize = 15;
  //color(int(random(0, 256)), int(random(0, 256)), int(random(0, 256)));
  
  public Complex(float a, float b, boolean check) {
    if(check) {
      real = a;
      imaginary = b; 
      radius = sqrt(real*real + imaginary*imaginary);
      theta = atan(imaginary / real);
      if(real < 0) {theta += PI;}
    }
    else {
      radius = a;
      theta = b;
      real = radius * cos(theta);
      imaginary = radius * sin(theta);
    }
  }
  
  public Complex() {
    real = 1;
    imaginary = 0;
    radius = 1;
    theta = 0;
  }
  
  public void drawMeRect() {
    fill(fillColor);
    if(scale/10 < minSize)
      ellipse(real * scale, -imaginary * scale, minSize, minSize);
    else if(scale/10 > maxSize)
      ellipse(real * scale, -imaginary * scale, maxSize, maxSize);
    else
      ellipse(real * scale, -imaginary * scale, scale/10, scale/10);
    
  }
 
  public void drawMeZeta() {
    fill(fillColor);
    //noStroke();
    if(scale/10 < minSize)
      ellipse(real * scale, -imaginary * scale, minSize, minSize);
    else if(scale/10 > maxSize)
      ellipse(real * scale, -imaginary * scale, maxSize, maxSize);
    else
      ellipse(real * scale, -imaginary * scale, scale/30, scale/30);
    
  }
  
  public void setReal(float a) {
    real = a;
    radius = sqrt(real*real + imaginary*imaginary);
    theta = atan(imaginary / real);
    if(real < 0) {theta += PI;}
  }
  
  public void setImaginary(float b) {
    imaginary = b;
    radius = sqrt(real*real + imaginary*imaginary);
    theta = atan(imaginary / real);
    if(real < 0) {theta += PI;}
  }
  
  public void setRadius(float r) {
    radius = r;
    real  = radius * cos(theta);
    imaginary  = radius * sin(theta);
  }
  
  public void setTheta(float t) {
    theta = t;
    real  = radius * cos(theta);
    imaginary  = radius * sin(theta);
  }
  
  public boolean revealCoordinates() {
    if(dist((mouseX - (width/2 - transform.x)), -(mouseY - (height/2 - transform.y)), real * scale, imaginary * scale) < 20) {
      fill(fillColor);
      textSize(20);
      text(this.toString(), real * scale, -(imaginary * scale + 10));
      //println(dist((mouseX - (width/2 - transform.x))/scale, -(mouseY - (height/2 - transform.y))/scale, real, imaginary));
      return true;
    }
    return false;
  }
  
  public String toString() {
    if(rectangular)
      return real + " + " + imaginary + "i";
    else
      return radius + "e^(" + theta + "i)";
  }

}
