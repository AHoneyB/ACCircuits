import java.util.Collections; 

class Complex implements Comparable<Complex> {
  float re;
  float im;
  float amp;
  float phase;
  
  float w,k;

  Complex(float r, float i) {
    re =r;
    im =i;
    amp = (float)sqrt(re*re+im*im);
    phase =atan2(im, re);
  }
  
  Complex mult(Complex c){
    Complex r =new Complex(0,0);
    r.re = re*re - c.re*c.re;
    r.im = re*c.im + c.re*im;
    return r;
    
  }
  
  @Override     
  public int compareTo(Complex number) {
    return (this.amp < number.amp ? -1 : 
            (this.amp == number.amp  ? 0 : 1)); 
  }
  
  String toSting() { 
    return "("+re+","+im+")";
  }
}

class ComplexSorter {

  ArrayList<Complex> listOfComplexnumbers;
  
  ComplexSorter(ArrayList<Complex> listOfComplexnumbers){
    this.listOfComplexnumbers=listOfComplexnumbers;
  }

  ArrayList<Complex> getSortedbyAmp(){
    Collections.sort(listOfComplexnumbers);
    return listOfComplexnumbers;
  }

}
