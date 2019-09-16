import controlP5.*;

Wave Vs, Vr, Ir;
Wave Vc, Vl;
ControlP5 cp5;
Slider slider;

float w0;         //angular frequency
Float R, Xc, Xl, Z;
float Vps, Ips;
float phasrVs;
float Vpr, Vpc, Vpl;
float Ipr, Ipc, Ipl;



void setup() {
  size(1200, 700);
  cp5 = new ControlP5(this);
  // horizontal scroller
  slider = cp5.addSlider("w0")
     .setPosition(20,20)
     .setSize(100,20)
     .setRange(0.125,8)
     ;
  w0 =1;  
  setCircuitValues();
  float xPos=120, yPos = 200;
   
  //float phasrVs = atan2((Xl-Xc),R);

  //yPos += 2.2*Vps;
  Vs = new Wave("Supply current", xPos, yPos, Vps, 1, w0, phasrVs, 255, 0, 0);  // "name",(px,py), amp,k,w ,phase ,RGB
  Ir = new Wave("Supply voltage", xPos+550, yPos, Ips, 1, w0, 0, 255, 0, 0);
 
  //yPos +=2.2*Vps;
  Vr = new Wave("Resistor current", xPos, yPos, Vpr, 1, w0, 0, 255, 128, 0); 

   
  //yPos +=2.5*Vps;
  Vc = new Wave("Capacitor current", xPos, yPos, Vpc, 1, w0, +HALF_PI, 0, 125, 125); 
    
  //yPos +=3*Vps;
  Vl = new Wave("Inductor current", xPos, yPos, Vpl, 1, w0, -HALF_PI, 125, 125, 0); 
  frameRate(20);

  println("Is= "+Ips+" A");  
  println("Z= "+Z+" ohm");
  println("Vs= "+Vps+" V");
  println("Ir= "+Ipr+" A");
  println("Ic= "+Ipc+" A");
  println("Il= "+Ipl+" A");
}

void setCircuitValues(){
  Ips =50;
  R = 1.0; 
  Xc = 1/w0;
  Xl = 1*w0;
  // calulate impedence
  Z=(float)Math.sqrt( (Xl-Xc)*(Xl-Xc) + R*R);
  // calulate phase
  phasrVs = -atan2((Xl-Xc), R);
  // Calculate component Source voltage 
  Vps = Z * Ips; 
  
  // Calculate component current
  Ipr=Vps/R;;
  Ipc =Vps/Xc ;
  Ipl =Vps/Xl ;
}

void draw() {
  background(230);
  if (mousePressed) {
  println("Pressed "+w0);
  setCircuitValues();
  Vr.setPhysicalValues(Vpr, 1, w0, 0); Vr.calcWave();
  Ir.setPhysicalValues(Ips, 1, w0, 0); Ir.calcWave();
  Vc.setPhysicalValues(Vpc, 1, w0, +HALF_PI); Vc.calcWave();
  Vl.setPhysicalValues(Vpl, 1, w0, -HALF_PI); Vl.calcWave();
  Vs.setPhysicalValues(Vps, 1, w0, phasrVs); Vs.calcWave();
}

  Vr.render();
  Ir.render();
  Vc.render();
  Vl.render();
  Vs.render();

  //Vs.renderOnlyPhasor();
  //Vr.renderOnlyPhasor();
  //Vc.renderOnlyPhasor();
  //Vl.renderOnlyPhasor();
  
}
