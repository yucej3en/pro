public class ControllThread extends Thread{

void serialsend(PVector xyz,boolean run,int fc,float pinch)
{
float zv=map(xyz.z,-200,200,90,0); // map z kusuratlı değeler ile aralıklandırma
float yv=map(xyz.y,150,400,4,64); //map y
float xv=map(xyz.x,-150,170,179,0);//buda olmazsa cba fnk var onu dene
float pv=map(pinch,1,0,0,80);
 if(fc>=2){run=true;} // el parmak sayısı ikiden az ise
 //kendime not açıları robot aparatına göre tekrar ayarla!!!!!!!!!!!!!!!!
 else
 run=false;
if(run&& zv<=90 && zv>=0 && yv<=64 && yv>=4 && xv<=179 && xv>=0){//veri göndermeyi belli kriterler sağlanırsa gönder
 String v1="S"+(int)xv+"X";
 String v2=(int)yv+"Y";
 String v3=(int)zv+"Z";
 String v4=(int)pv+"P";
 String sentdata=v1+v2+v3+v4;
port.write(sentdata); 
 println("göderilen deger: "+sentdata);
 } 
}// haberleşme için kullanılacak 
 
 void run()
 {
  
   String defaultpack= "S179X4Y0Z80P";
  for(Hand hand : leap.getHands())
   {   Hand drawhand=leap.getRightHand();
    Finger ft=hand.getThumb();
    Finger fp=hand.getPinkyFinger();
    Finger MiddleFinger =drawhand.getIndexFinger();
    PVector xyz=MiddleFinger.getRawPositionOfJointTip();
    PVector distanceThumb=ft.getRawPositionOfJointTip();
    PVector distancePinky=fp.getRawPositionOfJointTip();
    float pinch = drawhand.getPinchStrength();


  
   if(drawhand.isRight() && xyz.x<175 && xyz.x>-181 && xyz.y<470 && xyz.z>-220 && xyz.z<250)
     {
              

 /* //vektor sınırlandırma
   if(xyz.x>180) xyz.x=180;
   if(xyz.x<-150) xyz.x=-150;
   if(xyz.y<150) xyz.y=150;
   if(xyz.y>350) xyz.y=350;
   if(xyz.z<-180) xyz.z=-180;
   if(xyz.z>180) xyz.z=150;*/
    int[] dizi=int(xyz.array());
    fill(#1BE6F5);
    text("X mm: "+dizi[0],10,20);
    text("Y mm: "+dizi[1],10,40);
    text("Z mm: "+dizi[2],10,60);
    text("Tutma gücü: "+pinch,10,80);
    text("El id: "+drawhand.getId(),10,100);
   int fc =drawhand.countFingers();
   text("parmak sayısı: "+fc,10,120);
   int distinctness=int(abs(distanceThumb.x-distancePinky.x));
   if(distinctness<4)
    distinctness=1;
//Serial ile gönderilecek verilerin aralıga atanması
     if(distinctness==1 ){
        count=false;
        i++;
        println("i degeri: "+i+"fark:  "+int(abs(distanceThumb.x-distancePinky.x)));
      }
      if(i%2==0){count=true;}
if(count==false){
j++;
     println(j+"::"+defaultpack);

port.write(defaultpack);
}
else
serialsend(xyz,run,fc,pinch);
     
/////////////////////////////////////////////////////
   for(Finger fingers : drawhand.getFingers()){

   fingers.draw();  }
 
   }
   }
  }// methot override yapmak icin super k�m�n� sil kendi kriterlerini yaz 
 void start(){
  run();
 

 }
}
