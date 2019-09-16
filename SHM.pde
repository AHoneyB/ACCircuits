class Wave {

  ArrayList<Complex> wave;
  String s;
  float px, py;
  float w, k, phase;
  float R, G, B;
  float amp;
  float st;
  int num;
  int time, x;
  int date;
  float fp=80;

  Wave(String s, float px, float py, float a, float k, float w, float p, float R, float G, float B) {
    wave = new  ArrayList<Complex>();
    this.s = s;
    this.R = R;
    this.G = G;
    this.B = B;
    this.px = px;
    this.py = py;

    st=4;
    num = 100;
    time =0;
    x =0;
    
    setPhysicalValues(a, k,  w, p);
    calcWave();
  }

  void setPhysicalValues(float a, float k, float w, float p) {
    this.amp = a;
    this.phase = p;
    this.w=w;
    this.k=k;
  }
  
  void setFreq(float w){
    this.w=w;
  }
  
 

  void calcWave() {
    wave.clear();
    Float re, im;
    for (int i=0; i<num; i++) {
      float xx = map(i, 0, num, 0, TWO_PI/k);
      for (int j=0; j<num; j++) {
        float tt = map(j, 0, num, 0, TWO_PI/w);
        re = amp *  (float)(Math.cos((k*xx-w*tt+phase)));
        im = amp *  (float)(Math.sin((k*xx-w*tt+phase)));
        Complex c = new Complex(re, im);

        wave.add(c);
      }
    }
  }


  // RENDER   

  void renderOnlyPhasor() {

    renderPhasor(750, 500, time, R, G, B);
  }

  void render() {
    int dirc =0;
    if (time>=num) 
      time =0;

    renderPointSHM(px, py, time, R, G, B, dirc);
    renderPhasor(px, py, time, R, G, B);
    renderSHMform(px, py, R, G, B, dirc);

    time +=1;
  }


  void renderSHMform(float pX, float pY, float R, float G, float B, int dir) {
    strokeWeight(1);
    stroke(0, 50);
    if (dir==0) {   // Horizontal
      line(pX+fp, pY+amp, pX+fp, pY-amp );
      line(pX+fp, pY, pX+fp+num*st, pY );
    } else {      // Vertical
      line(pX+amp, pY+fp, pX-amp, pY+fp );
      line(pX, pY+1.5*amp, pX, pY+1.5*amp+num*st );
    }

    //textLabels( pX,  pY);


    beginShape();
    noFill();
    stroke(R, G, B);
    strokeWeight(1);
    for (int t=0; t<num; t++) {
      if (dir==0) 

        vertex(pX+st*t+fp, pY+wave.get(t).im );
      else
        vertex(pX+wave.get(t).re, pY+st*t+fp);
    }
    endShape();
    stroke(0);
  }

  void textLabels(float pX, float pY) {
    fill(0, 0, 0);
    text(s, pX+250, pY-amp-5);
  }

  void renderPointSHM(float pX, float pY, int t, float R, float G, float B, int dir) {

    fill(R, G, B);
    stroke(R, G, B);
    if (dir==0) {

      ellipse(pX+st*t+fp, pY+wave.get(t).im, 5, 5);
      // ellipse(pX+1.2*amp, pY+wave.get(t).im, 5, 5);
      // line(pX+1.2*amp, pY, pX+1.2*amp, pY+wave.get(t).im);
    } else {
      ellipse(pX+wave.get(t).re, pY+st*t+fp, 5, 5);
      // ellipse(pX+wave.get(t).re, pY+1.2*amp, 5, 5);
      //line(pX, pY+1.2*amp, pX+wave.get(t).re, pY+1.2*amp);
    }
  }



  void renderPhasor(float centerX, float centerY, int t, float R, float G, float B) {

    float dx=wave.get(t).re;
    float dy=wave.get(t).im;  

    noFill();
    stroke(0, 50);
    strokeWeight(1);
    ellipse(centerX, centerY, 2*amp, 2*amp);
    stroke(R, G, B);
    strokeWeight(2);
    line(centerX, centerY, centerX+dx, centerY+dy);
  }
}
