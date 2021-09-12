import processing.serial.*;
Serial Mipuerto;
float HA,HB,HC;
float VA,VB,VC;
int milisegundos;
int i=0;
float VCC=3.3;
void setup() {
size(1000, 1000, P3D);
fill(204);
 
  Mipuerto =new Serial(this, "COM6", 2000000);// me conecto con el puerto 
  Mipuerto.clear();
  Mipuerto.bufferUntil('\n');//carga el buffer de datos hastq ue encuentres un caracter especial en este caso el enter \n

}
void draw() {
 background(0);
 translate(width/2, height/2, -width);
 rotateY(map(mouseX, 0, width, -PI, PI));
 rotateX(map(mouseY, 0, height, -PI, PI));
fill(#FFFFFF);
strokeWeight (1);
 stroke(255);
 textSize(250);
 text("x",900, 0, 0);
 line(900, 0, 0, -900, 0, 0);
  text("y",0, -900, 0);
 line(0, 900, -0, 0, -900, 0);
  text("z",0, 0, 900);
 line(0, 0, -900, 0, 0, 900);


fill(255, 150, 100,150);
  box(100);
  

  CambioGravedad();
 
}
void CambioGravedad(){
 pushMatrix();
 stroke(0,255,0);//verde
 //rotateY(radians(45));
rotateX(radians(45));
strokeWeight (10);
line(0, 0, 0, HA*1000, HB*1000, HC*1000);//Para ver bien el vector
popMatrix();

}



void serialEvent(Serial p) {

 String Mensaje =Mipuerto.readString();//leemos lo que hay en el puerto
  String[] PaqueteMensaje= splitTokens(Mensaje, ",\n\r");//separa mensajes a apartir de un caracter, ademas quito el enter y el retorno de carril 
VA= float(PaqueteMensaje[0])*3.3/4096;
VB= float(PaqueteMensaje[1])*3.3/4096;
VC= float(PaqueteMensaje[2])*3.3/4096;
milisegundos= int(PaqueteMensaje[3]);
i++;

  HA=(VA-(VCC/2))/(0.33);//RESULTADO EN GAUSS
  HB=(VB-(VCC/2))/(0.33);
  HC=(VC-(VCC/2))/(0.33);
  println(HA);
  println(HB);
  println(HC);

}
