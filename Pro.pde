import processing.serial.*;
import de.voidplus.leapmotion.*;
LeapMotion leap;//leapMotion için kullanılacak nesne
Serial port;//Ardunioyo ya veri gönderebilmek için oluşturlan port nesnesi
ControllThread  myct;// sağ el kontrolu yapacak ve el çizimi yapan thread
boolean run=false;
 boolean count=true;
   int i=0,j=0;
void setup(){
  textSize(19);//kullanılan metin boyutu
  size(1000,800,OPENGL);//pencere boytu opengl modunda açılacağını belirtiyoruz
  myct= new ControllThread();//thread nesnes tanıtıtmı
// thread("mymethot");//processing kendi parametresiz fonksiyon  thread
  leap =new LeapMotion(this);
 port= new Serial(this,Serial.list()[0],115200);//port nesnememiz belirlenen portu dinliyor

}
void draw(){
background(111,111,111);// pencere açılış ile arka plan rengi
myct.start();// controll ve çizim thread başlatılması
int fps = leap.getFrameRate();//fps bilgisi
fill(#1BE6F5);
text(fps + " fps",900,20);//fps ekrana yazdır 
}
