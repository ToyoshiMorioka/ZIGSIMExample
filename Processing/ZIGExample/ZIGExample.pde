import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.io.IOException;

final int port = 50000;
UDPReceiever udp;
void setup() {
  udp = new UDPReceiever();
  udp.setup(this, port);
  udp.run();
} 

void draw() {
  networkUpdate();
}

void networkUpdate(){

}

void recieveMessage(UDPReceiever data){
  //System.out.println("message:" + data.message);
  ZIGJSON zig = new ZIGJSON();
  boolean success = zig.toParams(data.message);
  if (success){
    debugZIGJSON(zig);
  }
}

void debugZIGJSON(ZIGJSON zigjson){
    System.out.println("device:name:" + zigjson.device.name);
    System.out.println("device:uuid:" + zigjson.device.uuid);
    System.out.println("device:timestamp:" + zigjson.timeStamp.timeString);
    
    // accel
    if (zigjson.hasAccel) {
      System.out.println(zigjson.device.uuid + " accel:x:" + zigjson.accel.x);
      System.out.println(zigjson.device.uuid + " accel:y:" + zigjson.accel.y);
      System.out.println(zigjson.device.uuid + " accel:z:" + zigjson.accel.z);
    }else {
      System.out.println(zigjson.device.uuid + " has no accel sensor.");
    }
    
    // gravity
    if (zigjson.hasGravity) {
      System.out.println(zigjson.device.uuid + " gravity:x:" + zigjson.gravity.x);
      System.out.println(zigjson.device.uuid + " gravity:y:" + zigjson.gravity.y);
      System.out.println(zigjson.device.uuid + " gravity:z:" + zigjson.gravity.z);
    }else {
      System.out.println(zigjson.device.uuid + " has no gravity sensor.");
    }
    
    // gyro 
    if (zigjson.hasGyro) {
      System.out.println(zigjson.device.uuid + " gyro:x:" + zigjson.gyro.x);
      System.out.println(zigjson.device.uuid + " gyro:y:" + zigjson.gyro.y);
      System.out.println(zigjson.device.uuid + " gyro:z:" + zigjson.gyro.z);
    }else {
      System.out.println(zigjson.device.uuid + " has no gyro sensor.");
    }
    
    // quaternion
    if (zigjson.hasQuaternion) {
      System.out.println(zigjson.device.uuid + " quaternion:x:" + zigjson.quaternion.x);
      System.out.println(zigjson.device.uuid + " quaternion:y:" + zigjson.quaternion.y);
      System.out.println(zigjson.device.uuid + " quaternion:z:" + zigjson.quaternion.z);
      System.out.println(zigjson.device.uuid + " quaternion:w:" + zigjson.quaternion.w);
    }else {
      System.out.println(zigjson.device.uuid + " has no quaternion sensor.");
    }
    
    // compass
    if (zigjson.hasCompass) {
      System.out.println(zigjson.device.uuid + " compass:faceup:" + zigjson.compass.faceUp);
      System.out.println(zigjson.device.uuid + " compass:compass:" + zigjson.compass.compass);
    }else {
      System.out.println(zigjson.device.uuid + " has no compass sensor.");
    }
    
    // gps
    if (zigjson.hasGPS) {
      System.out.println(zigjson.device.uuid + " gps:longitude:" + zigjson.gps.longitude);
      System.out.println(zigjson.device.uuid + " gps:latitude:" + zigjson.gps.latitude);
    }else {
      System.out.println(zigjson.device.uuid + " has no gps sensor.");
    }
    
    // pressure
    if (zigjson.hasPressure) {
      System.out.println(zigjson.device.uuid + " pressure:pressure:" + zigjson.pressure.pressure);
      System.out.println(zigjson.device.uuid + " pressure:altitude:" + zigjson.pressure.altitude);
    }else {
      System.out.println(zigjson.device.uuid + " has no pressure sensor.");
    }
    
    // beacon
    if (zigjson.hasBeacon) {
      for ( int i = 0; i < zigjson.beacons.size(); i++) {
        Beacon temp = zigjson.beacons.get(i);
        System.out.println(zigjson.device.uuid + " beacon" + i +":uuid" + temp.uuid);
        System.out.println(zigjson.device.uuid + " beacon" + i +":major" + temp.major);
        System.out.println(zigjson.device.uuid + " beacon" + i +":minor" + temp.minor);
        System.out.println(zigjson.device.uuid + " beacon" + i +":rssi" + temp.rssi);
      }
    }else {
      System.out.println(zigjson.device.uuid + " has no beacon sensor.");
    }
    
    // touch
    if (zigjson.hasTouch) {
      for ( int i = 0; i < zigjson.touchPoints.size(); i++) {
        TouchPoint temp = zigjson.touchPoints.get(i);
        if (zigjson.hasTouch2D){
          System.out.println(zigjson.device.uuid + " touch" + i +":x" + temp.x);
          System.out.println(zigjson.device.uuid + " touch" + i +":y" + temp.y);
        }
        if (zigjson.hasTouchRadius){
          System.out.println(zigjson.device.uuid + " touch" + i +":radius" + temp.radius);
        }
        if (zigjson.hasTouchForce){
          System.out.println(zigjson.device.uuid + " touch" + i +":force" + temp.force);
        }
      }
    }else {
      System.out.println(zigjson.device.uuid + " has no touch sensor.");
    }
    
    // proximity monitor
    if (zigjson.hasProximityMonitor) {
      System.out.println(zigjson.device.uuid + " proximityMonitor:proximityMonitor:" + zigjson.proximityMonitor.proximityMonitor);
    }else {
      System.out.println(zigjson.device.uuid + " has no proximity monitor sensor.");
    }
    
    // mic level
    if (zigjson.hasMicLevel) {
      System.out.println(zigjson.device.uuid + " micLevel:average:" + zigjson.micLevel.average);
      System.out.println(zigjson.device.uuid + " micLevel:max:" + zigjson.micLevel.max);
    }else {
      System.out.println(zigjson.device.uuid + " has no mic level sensor.");
    }
    
    // remote control
    if (zigjson.hasRemoteControl) {
      System.out.println(zigjson.device.uuid + " remoteControl:playPause:" + zigjson.remoteControl.playPause);
      System.out.println(zigjson.device.uuid + " remoteControl:volumeUp:" + zigjson.remoteControl.volumeUp);
      System.out.println(zigjson.device.uuid + " remoteControl:volumeDown:" + zigjson.remoteControl.volumeDown);
    }else {
      System.out.println(zigjson.device.uuid + " has no remote control sensor.");
    } 
}