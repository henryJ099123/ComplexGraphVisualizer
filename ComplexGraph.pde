public PVector tPoint;
public PVector transform = new PVector(0,0);
public PVector mouse;
float frame = 0;

//controls zooming in and out
public float scale = 100;

//controls how many points to include in the infinite sum
public float cutoff = 300;
public boolean update = false;
public boolean printCoordinates = true;
public boolean showInput = false;
//public boolean rectangular = true;

public ArrayList<Complex> complexNumbers;

//input complex number into the functions decided by the user
public Complex input;

//bunch of testers
public Complex test1;
public Complex test2;
public Complex test3;
public Complex test4;
public Complex test5;
public Complex test6;

void setup() {
  size(1400, 800);
  /*
  test1 = new Complex(2, 4, true);
  test2 = new Complex(3, 5, true);
  test3 = addComplex(test1, test2);
  test4 = multComplex(test1, test2);
  test5 = multComplex(test1, test1);
  test6 = powComplex(test1, -1);
  
  test1 = new Complex(-0.1, 0.3, true);
  test2 = powComplex(test1, 3);
  test3 = powComplex1(test1, 3);
  println(test1, test1.radius, test1.theta);
  println(test2, test2.radius, test2.theta);
  println(test3, test3.radius, test3.theta);
  */
  
  test1 = new Complex(5.4, 3.9, true);
  test2 = new Complex(2.9, 6.5, true);
  test3 = powImaginaryComplex(test1, test2);
  println(test3);
  
  test4 = new Complex(5, 4, false);
  println("test 4: " + test4);
  test5 = new Complex(1.9, 8.4, true);
  println("test 5: " + test5);
  test6 = powImaginaryComplex(test4, test5);
  println("test6: " + test6);
  
  //input = new Complex(0.5, 14.134725, true);
  /*
  test1 = new Complex(0.5, 14.2, true);
  test2 = new Complex(0, 0, true);
  for(int i = 1; i < 1001; i++) {
    test3 = divComplex(new Complex(), powImaginaryComplex(new Complex(i, 0, true), test1));
    test2 = addComplex(test2, test3);
  }
  */
  //println(test2);
  input = new Complex();
  input.fillColor = color(255, 0, 0);
  
  /*
  Complex test4 = new Complex(0.5, 14.134725, true);
  Complex test5 = new Complex(-2, 0, true);
  println(calcZeta(test4));
  println(calcZeta(test5));
  */
  
  //println(test1, test2, test3, test4, test5, test6);
  
  complexNumbers = new ArrayList<Complex>();
  //complexNumbers.add(input);
}

void draw() {
  stroke(1);
  frame++;
  mouse = new PVector(mouseX, mouseY);
  background(255);
  translate(width/2 - transform.x, height/2 - transform.y);
  
  //major axes
  fill(0);
  strokeWeight(3);
  line(0, -height/2 * 10, 0, height/2 * 10);
  line(-width/2 * 10, 0, width/2 * 10, 0);
  
  
  //gridlines and coordinates
  strokeWeight(1);
  textSize(15);
  //vertical lines
  for(int i = int((-width/2 + transform.x)/scale); i < int((width/2 + transform.x)/scale) + 1; i++) {
    fill(0);
    text(i, i * scale + 5, 15);
    fill(200);
    line(i * scale, -height/2 * 10, i * scale, height/2 * 10);
  }
  //horizontal lines
  for(int i = int((-height/2 - transform.y)/scale); i < int((height/2 - transform.y)/scale) + 1; i++) {
    fill(0);
    if(i != 0)
      text(i + "i", 5, -i * scale + 15);
    fill(200);
    line(-width/2 * 10, -i * scale, width/2 * 10, -i * scale);
  }
  noFill();
  ellipse(0, 0, 2 * scale, 2 * scale);
  
  //execute rest
  /*
  test1.drawMe();
  test2.drawMe();
  test3.drawMe();
  test4.drawMe();
  */
  
  updateInput();
  drawGeo1Function(input);
  drawZetaFunction(input);
  //drawCriticalLine();
  //drawCriticalLine();
  //drawZetaAnalyticFunction(input);
  drawComplexNumbers();
  printCoordinates = true;
  complexNumbers.clear();
  //println(scale);
}

//takes in two complex numbers, returns their sum
Complex addComplex(Complex first, Complex second) {
     return new Complex(first.real + second.real, first.imaginary + second.imaginary, true);
  }
  
//takes in two complex numbers, returns their product
Complex multComplex(Complex first, Complex second) {
   Complex temp = new Complex();
   temp.setReal(first.real * second.real - first.imaginary * second.imaginary);
   temp.setImaginary(first.imaginary * second.real + first.real * second.imaginary);
   return temp;
}

Complex negComplex(Complex z) {
  Complex temp = new Complex(-z.real, -z.imaginary, true);
  return temp;
}

//takes in a complex number and an exponent, spits out that complex number raised to this integer exponent

/*
Complex powComplex(Complex num, int exp) {
  Complex temp = new Complex(1, 0, true);
  while(exp > 0) {
    temp = multComplex(temp, num);
    exp--;
  }
  return temp;
}
*/


Complex powComplex(Complex z, float x) {
  Complex temp = new Complex();
  temp.setRadius(pow(z.radius, x));
  temp.setTheta(x * z.theta);
  return temp;
}

//basically, changes z1/z2 into z1 * 1/z2, 
//uses a formula for 1/z2 (derived from 1/(a+bi) using conjugates)
//and then multiplies z1 by this result
Complex divComplex(Complex z1, Complex z2) {
  return multComplex(z1, new Complex(z2.real/pow(z2.radius, 2), -z2.imaginary/pow(z2.radius, 2), true));
}

//derived by changing (re^iθ)^(a+bi) into two new complex numbers being multiplied,
//which are (r^a)(e^(bi*ln(r))) and (e^iaθ)/(e^bθ)
//so proud of this derivation!!
//this derivation is wrong. only for solely imaginary exponents D:
Complex powImaginaryComplex(Complex z, Complex exp) {
  //Complex temp1 = new Complex(pow(z.radius, exp.real), exp.imaginary * log(z.radius), false);
  //Complex temp2 = new Complex(exp(-exp.imaginary * z.theta), exp.real * z.theta, false);
  
  Complex temp1 = new Complex(exp(exp.real*log(z.radius) - exp.imaginary*z.theta), exp.imaginary * log(z.radius) + z.theta * exp.real, false);
  
  //return multComplex(temp1, temp2);
  return temp1;
  //Complex temp1 = 
}

//complexNumbers arrayList controls
void drawComplexNumbers() {
  for(Complex z: complexNumbers) {
    z.drawMeRect();
    //z.drawMeZeta();
    if(printCoordinates) {
      if(z.revealCoordinates())
        printCoordinates = false;
    }
  }
}



//this is the series: 1 + z + z^2 + z^3 + z^4...
void drawGeo1Function(Complex z) {
  Complex sum;
  for(int i = 0; i < cutoff; i++) {
    sum = powComplex(z, i);
    for(int j = 0; j < i; j++) {
      sum = addComplex(sum, powComplex(z, j));
    }
    complexNumbers.add(sum);
    
    //powComplex(z, i).drawMe();
  }
}

void drawZetaFunction(Complex z) {
  Complex sum;
  for(int i = 1; i < cutoff; i++) {
    sum = divComplex(new Complex(), powImaginaryComplex(new Complex(i, 0, true), z));
    for(int j = 1; j < i; j++) {
      sum = addComplex(sum, divComplex(new Complex(), powImaginaryComplex(new Complex(j, 0, true), z)));
    }
    sum.fillColor = color(0, 255, 0);
    complexNumbers.add(sum);
  }
}

Complex calcZeta(Complex input) {
  Complex sum = new Complex();
  Complex term;
  Complex coeffPart = powImaginaryComplex(new Complex(2,0,true), addComplex(new Complex(), negComplex(input)));
  Complex coeff = divComplex(new Complex(), addComplex(new Complex(), negComplex(coeffPart)));
  for (float i = 1; i < 100; i++) {
    term = divComplex(new Complex(), powImaginaryComplex(new Complex(i, 0, true), input));
    if(i % 2 == 0) {term = negComplex(term);}
    sum = addComplex(sum, term);
  }
  return multComplex(sum, coeff);
}

void drawCriticalLine() {
  Complex sum;
  Complex term;
  for(float i = 0; i < frame/20; i += 0.01) {
    sum = new Complex(0, 0, true);
    for(int j = 1; j < 100; j++) {
      term = divComplex(new Complex(), powImaginaryComplex(new Complex(j, 0, true), new Complex(0.5, i, true)));
      sum = addComplex(sum, term);
    }
    sum.fillColor = color(255, 0, 255);
    complexNumbers.add(sum);
 
  }
  
}


/*
void drawZetaAnalyticFunction(Complex s) {
  Complex sum;
  Complex one = new Complex();
  Complex base2part = powImaginaryComplex(new Complex(2, 0, true), addComplex(one, negComplex(s)));
  Complex denom = addComplex(one, negComplex(base2part));
  Complex coeff = divComplex(one, denom);
  println(coeff);
  for(int i = 1; i < cutoff; i++) {
    sum = divComplex(new Complex(), powImaginaryComplex(new Complex(i, 0, true), s));
    sum = multComplex(sum, powComplex(new Complex(-1, 0, true), i - 1));
    sum = multComplex(sum, coeff);
    for(int j = 1; j < cutoff; j++) {
      sum = divComplex(new Complex(), powImaginaryComplex(new Complex(j, 0, true), s));
      sum = multComplex(sum, powComplex(new Complex(-1, 0, true), j - 1));
      sum = multComplex(sum, coeff);
    }
    sum.fillColor = color(255, 0, 221);
    complexNumbers.add(sum);
  }
}
*/
  
void mousePressed() {
  tPoint = PVector.add(mouse, transform);
}

void mouseDragged() {
  transform = PVector.sub(tPoint, mouse);
}

void updateInput() {
  if(update) {
    input.setReal((mouseX - (width/2 - transform.x))/scale);
    input.setImaginary(-(mouseY - (height/2 - transform.y))/scale);
    //input = new Complex((mouseX - (width/2 - transform.x))/scale, -(mouseY - (height/2 - transform.y))/scale);
  }
  if(showInput) {
    input.drawMeRect();
    input.revealCoordinates();
  }
}


void keyPressed() {
  if(keyCode == 32) {
    transform.x = 0;
    transform.y = 0;
    scale = 100;
  }
  if(keyCode == SHIFT)
    update = !update;
  
  if(keyCode == RETURN || keyCode == ENTER) {
    showInput = !showInput;
  }
  
  if(key == 'z')
    Complex.rectangular = !Complex.rectangular;
    
    /*
    println(input);
    println(mouseX, mouseY);
    println((mouseX - transform.x)/scale, (mouseY - transform.y)/scale);
    */
  
  if(keyCode == UP && scale > 40) {
    scale -= 5;
  }
  if(keyCode == DOWN) {
    scale += 5; 
  }
  
}
