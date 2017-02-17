import netP5.*;
import oscP5.*;

int portNumber = 50000;
String uuid = "uuid";
OscP5 oscP5;

void setup() {
  size(400, 400);
  background(0);
  noStroke();
  
  oscP5 = new OscP5(this, portNumber);
}

void draw() {
}

void oscEvent(OscMessage msg) {
  print(" addrpattern: "+msg.addrPattern());
  println(" typetag: "+msg.typetag());
  
  String baseAddr = "/ZIGSIM/" + uuid + "/";
  // accel 
  if(msg.checkAddrPattern(baseAddr + "accel") == true ) {
    float accelX = msg.get(0).floatValue();
    float accelY = msg.get(1).floatValue();
    float accelZ = msg.get(2).floatValue();
    println("accel x:" + accelX + " y:" + accelY + " z:" + accelZ);
  }
  
  // gravity
  if(msg.checkAddrPattern(baseAddr + "gravity") == true ) {
    float gravityX = msg.get(0).floatValue();
    float gravityY = msg.get(1).floatValue();
    float gravityZ = msg.get(2).floatValue();
    println("gravity x:" + gravityX + " y:" + gravityY + " z:" + gravityZ);
  }
  
  // gyro
  if(msg.checkAddrPattern(baseAddr + "gyro") == true ) {
    float gyroX = msg.get(0).floatValue();
    float gyroY = msg.get(1).floatValue();
    float gyroZ = msg.get(2).floatValue();
    println("gyro x:" + gyroX + " y:" + gyroY + " z:" + gyroZ);
  }
  
  // quaternion
  if(msg.checkAddrPattern(baseAddr + "quaternion") == true ) {
    float quaternionX = msg.get(0).floatValue();
    float quaternionY = msg.get(1).floatValue();
    float quaternionZ = msg.get(2).floatValue();
    float quaternionW = msg.get(3).floatValue();
    println("quaternion x:" + quaternionX + " y:" + quaternionY + " z:" + quaternionZ + " w:" + quaternionW);
  }
  
  // compass
  if(msg.checkAddrPattern(baseAddr + "compass") == true ) {
    float angle = msg.get(0).floatValue();
    int faceup = msg.get(1).intValue();
    println("compass angle:" + angle + " faceup:" + faceup);
  }
  
  // pressure
  if(msg.checkAddrPattern(baseAddr + "pressure") == true ) {
    float pressure = msg.get(0).floatValue();
    float altitude = msg.get(1).floatValue();
    println("pressure pressure:" + pressure + " altitude:" + altitude);
  }
  
  // gps
  if(msg.checkAddrPattern(baseAddr + "gps") == true ) {
    float latitude = msg.get(0).floatValue();
    float longitude = msg.get(1).floatValue();
    println("gps latitude:" + latitude + " longitude:" + longitude);
  }
  
  // touches
  int touchCount = 0;
  if(msg.checkAddrPattern(baseAddr + "touchcount") == true ) {
    touchCount = msg.get(0).intValue();
    println("touch count:" + touchCount);
  }
  
  if(msg.checkAddrPattern(baseAddr + "touch0") == true ) {
      float x = msg.get(0).floatValue();
      float y = msg.get(1).floatValue();
      
      // ver 1.3.1 touch radius or touch force
      // float radius = msg.get(2).floatValue();
      // float power = msg.get(3).floatValue();
      println("touch" + 0 + " x:" + x + " y:" + y);
   }
  
  // ver 1.3.4 touch radius
  if(msg.checkAddrPattern(baseAddr + "touchradius0") == true ) {
      float radius = msg.get(0).floatValue();
      println("touchradius0 x:" + radius);
   }
  
  // ver 1.3.4 force touch
  if(msg.checkAddrPattern(baseAddr + "touchforce0") == true ) {
      float force = msg.get(0).floatValue();
      println("touchforce0 x:" + force);
   }
  
  
  // beacon
  int beaconCount = 0;
  if(msg.checkAddrPattern(baseAddr + "beaconcount") == true ) {
    beaconCount = msg.get(0).intValue();
    println("beacon count:" + beaconCount);
  }
  
  if(msg.checkAddrPattern(baseAddr + "beacon0") == true ) {
      String uuid = msg.get(0).stringValue();
      float major = msg.get(1).floatValue();
      float minor = msg.get(2).floatValue();
      float rssi = msg.get(3).floatValue();
      // float radius = msg.get(2).floatValue();
      // float power = msg.get(3).floatValue();
      println("beacon0 uuid:" + uuid + " major:" + major + " minor:" + minor + " rssi:" + rssi);
   }
  
  // proximity monitor
  if(msg.checkAddrPattern(baseAddr + "proximitymonitor") == true ) {
    int isEnable = msg.get(0).intValue();
    println("proximity monitor:" + isEnable);
  }
  
  // mic level
  if(msg.checkAddrPattern(baseAddr + "miclevel") == true ) {
    float max = msg.get(0).floatValue();
    float average = msg.get(1).floatValue();
    println("mic level max:" + max + " average:" + average);
  }
  
  // remote control
  if(msg.checkAddrPattern(baseAddr + "remotecontrol") == true ) {
    int playPause = msg.get(0).intValue();
    int volumeUp = msg.get(1).intValue();
    int volumeDown = msg.get(2).intValue();
    println("remote control playpause:" + playPause + " volumeup:" + volumeUp + " volumedown:" + volumeDown);
  }
}