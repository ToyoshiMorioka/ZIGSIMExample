class ZIGJSON {
  Device device;
  TimeStamp timeStamp;
  
  // accel sensor
  boolean hasAccel;
  Accel accel;
  
  // gravity sensor;
  boolean hasGravity;
  Gravity gravity;
  
  // gyro sensor
  boolean hasGyro;
  Gyro gyro;
  
  // quaternion sensor
  boolean hasQuaternion;
  Quaternion quaternion;
  
  // compass sensor
  boolean hasCompass;
  Compass compass;
  
  // pressure sensor
  boolean hasPressure;
  Pressure pressure;
  
  // gps sensor
  boolean hasGPS;
  GPS gps;
  
  // touch sensor
  boolean hasTouch;
  boolean hasTouch2D;
  boolean hasTouchRadius;
  boolean hasTouchForce;
  ArrayList<TouchPoint> touchPoints;
  
  // beacon sensor
  boolean hasBeacon;
  ArrayList<Beacon> beacons;
  
  // proximity monitor sensor
  boolean hasProximityMonitor;
  ProximityMonitor proximityMonitor;
  
  // mic level
  boolean hasMicLevel;
  MicLevel micLevel;
  
  // remote control
  boolean hasRemoteControl;
  RemoteControl remoteControl;
  
  void initParams(){
    device = new Device();
    timeStamp = new TimeStamp();
    hasAccel = false;
    hasGravity = false;
    hasGyro = false;
    hasQuaternion = false;
    hasCompass = false;
    hasGPS = false;
    hasBeacon = false;
    //beacons = new Beacon();
    hasTouch = false;
    // touches
    hasTouch2D = false;
    hasTouchRadius = false;
    hasTouchForce = false;
    hasProximityMonitor = false;
    hasMicLevel = false;
    hasRemoteControl = false;
  }
  
  boolean toParams(String message){
    initParams();
    //String copy = message;
    //ZIGJSON result = new ZIGJSON();
    JSONObject main = JSONObject.parse(message);

    // device(must)
    boolean result = setDevice(main);
    if (result != true) {
      return false;
    }
    // timestamp(must)
    result = setTimeStamp(main);
    if (result != true) {
      return false;
    }
    
    JSONObject sensorData = new JSONObject();
    String sensorDataTag = "sensordata";
    if (JSONObjectUtility.hasJSONObject(main, sensorDataTag)) {
      sensorData = main.getJSONObject(sensorDataTag);
    }else {
      return true;
    }
    
    // accel
    hasAccel = setAccel(sensorData);
    // gravity
    hasGravity = setGravity(sensorData);
    // gyro
    hasGyro = setGyro(sensorData);
    // qusternion
    hasQuaternion = setQuaternion(sensorData);
    // compass
    hasCompass = setCompass(sensorData);
    // gps
    hasGPS = setGPS(sensorData);
    // pressure
    hasPressure = setPressure(sensorData);
    // Beacon
    hasBeacon = setBeacons(sensorData);
    
    // Touch
    hasTouch = setTouchPoints(sensorData);
    
    // proximity monitor
    hasProximityMonitor = setProximityMonitor(sensorData);
    // mic level
    hasMicLevel = setMicLevel(sensorData);
    // remote control
    hasRemoteControl = setRemoteControl(sensorData);

    //System.out.println(n + " " + a);  // prints "Alice 20"
    return true;
  }
  
  boolean setDevice (JSONObject src) {
    String deviceTag = "device";
    if (JSONObjectUtility.hasJSONObject(src, deviceTag)) {
      JSONObject deviceJSON = src.getJSONObject(deviceTag);
      System.out.println("debug:" + deviceJSON.toString());
      this.device.name = deviceJSON.getString("name", "no data");
      this.device.uuid = deviceJSON.getString("uuid", "no data");
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setTimeStamp (JSONObject src) {
    String timestampTag = "timestamp";
    if (JSONObjectUtility.hasString(src, timestampTag)) {
      timeStamp.timeString = src.getString(timestampTag);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setAccel (JSONObject src) {
    String tag = "accel";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      accel = new Accel();
      JSONObject obj = src.getJSONObject(tag);
      accel.x = obj.getFloat("x", 0.0);
      accel.y = obj.getFloat("y", 0.0);
      accel.z = obj.getFloat("z", 0.0);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setGyro (JSONObject src) {
    String tag = "gyro";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      gyro = new Gyro();
      JSONObject obj = src.getJSONObject(tag);
      gyro.x = obj.getFloat("x", 0.0);
      gyro.y = obj.getFloat("y", 0.0);
      gyro.z = obj.getFloat("z", 0.0);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setGravity (JSONObject src) {
    String tag = "gravity";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      gravity = new Gravity();
      JSONObject obj = src.getJSONObject(tag);
      gravity.x = obj.getFloat("x", 0.0);
      gravity.y = obj.getFloat("y", 0.0);
      gravity.z = obj.getFloat("z", 0.0);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setQuaternion (JSONObject src) {
    String tag = "quaternion";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      quaternion = new Quaternion();
      JSONObject obj = src.getJSONObject(tag);
      quaternion.x = obj.getFloat("x", 0.0);
      quaternion.y = obj.getFloat("y", 0.0);
      quaternion.z = obj.getFloat("z", 0.0);
      quaternion.w = obj.getFloat("w", 0.0);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setCompass (JSONObject src) {
    String tag = "compass";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      compass = new Compass();
      JSONObject obj = src.getJSONObject(tag);
      compass.faceUp = obj.getBoolean("faceup", false);
      compass.compass = obj.getFloat("compass", 0.0);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setGPS (JSONObject src) {
    String tag = "gps";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      gps = new GPS();
      JSONObject obj = src.getJSONObject(tag);
      gps.longitude = obj.getFloat("longitude", 0.0);
      gps.latitude = obj.getFloat("latitude", 0.0);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setPressure (JSONObject src) {
    String tag = "pressure";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      pressure = new Pressure();
      JSONObject obj = src.getJSONObject(tag);
      pressure.altitude = obj.getFloat("altitude", 0.0);
      pressure.pressure = obj.getFloat("pressure", 0.0);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setProximityMonitor (JSONObject src) {
    String tag = "proximitymonitor";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      proximityMonitor = new ProximityMonitor();
      JSONObject obj = src.getJSONObject(tag);
      proximityMonitor.proximityMonitor = obj.getBoolean("proximitymonitor", false);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setMicLevel (JSONObject src) {
    String tag = "miclevel";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      micLevel = new MicLevel();
      JSONObject obj = src.getJSONObject(tag);
      micLevel.max = obj.getFloat("max", 0.0);
      micLevel.average = obj.getFloat("average", 0.0);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setRemoteControl (JSONObject src) {
    String tag = "remotecontrol";
    if (JSONObjectUtility.hasJSONObject(src, tag)) {
      remoteControl = new RemoteControl();
      JSONObject obj = src.getJSONObject(tag);
      remoteControl.volumeUp = obj.getBoolean("volumeup", false);
      remoteControl.volumeDown = obj.getBoolean("volumedown", false);
      remoteControl.playPause = obj.getBoolean("playpause", false);
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setTouchPoints (JSONObject src) {
    String tag = "touch";
    if (JSONObjectUtility.hasJSONArray(src, tag)) {
      touchPoints = new ArrayList<TouchPoint>();
      JSONArray arrays = src.getJSONArray(tag);
      for (int i = 0; i < arrays.size(); i++) {
        JSONObject item = arrays.getJSONObject(i); 
        TouchPoint newPoint = new TouchPoint();
        boolean getNew = false;
        
        // touch 2d
        if (JSONObjectUtility.hasFloat(item, "x") && JSONObjectUtility.hasFloat(item, "y")) {
          getNew = true;
          hasTouch2D = true;
          newPoint.x = item.getInt("x", 0);
          newPoint.y = item.getInt("y", 0);
        }else {
          hasTouch2D = false;
        }
 
        // touch radius
        if (JSONObjectUtility.hasFloat(item, "radius")) {
          getNew = true;
          hasTouchRadius = true;
          newPoint.radius = item.getFloat("radius", 0.0);
        }else {
          hasTouchRadius = false;
        }
        // touch force
        if (JSONObjectUtility.hasFloat(item, "force")) {
          getNew = true;
          hasTouchForce = true;
          newPoint.force = item.getFloat("force", 0.0);
        }else {
          hasTouchForce = false;
        }
        // add
        if (getNew) {
          touchPoints.add(newPoint);
        }
      }
    }else {
      return false;
    } 
    return true;
  }
  
  boolean setBeacons (JSONObject src) {
    String tag = "beacon";
    if (JSONObjectUtility.hasJSONArray(src, tag)) {
      beacons = new ArrayList<Beacon>();
      JSONArray arrays = src.getJSONArray(tag);
      for (int i = 0; i < arrays.size(); i++) {
        JSONObject item = arrays.getJSONObject(i); 
        Beacon newPoint = new Beacon();
        
        newPoint.uuid = item.getString("x", "no data");
        newPoint.minor = item.getInt("minor", 0);
        newPoint.major = item.getInt("major", 0);
        newPoint.rssi = item.getInt("rssi", 0);
        // add
        beacons.add(newPoint);
      }
    }else {
      return false;
    } 
    return true;
  }
}

static class JSONObjectUtility{
  // JSON Object Utility
  // https://github.com/processing/processing/blob/master/core/src/processing/data/JSONObject.java
  
  public static boolean hasJSONObject(JSONObject object, String name){
      try{
        object.getJSONObject(name);
      }catch(Exception e){
        return false;
      }
      return true;
    }
    
   public static boolean hasString(JSONObject object, String name){
     try{
        object.getString(name);
     }catch(Exception e){
        return false;
     }   
      return true;
    }
    
    public static boolean hasInt(JSONObject object, String name){
     try{
        object.getInt(name);
     }catch(Exception e){
        return false;
     }   
      return true;
    }
    
    public static boolean hasFloat(JSONObject object, String name){
     try{
        object.getFloat(name);
     }catch(Exception e){
        return false;
     }   
      return true;
    }
    
    public static boolean hasJSONArray(JSONObject object, String name){
     try{
        object.getJSONArray(name);
     }catch(Exception e){
        return false;
     }   
      return true;
    }
    
    public static boolean hasBoolean(JSONObject object, String name){
     try{
        object.getBoolean(name);
     }catch(Exception e){
        return false;
     }   
      return true;
    }
}

class Device{
  String name = "";
  String uuid = "";
}

class TimeStamp{
  int year;
  int month;
  int day;
  int hour;
  int minuite;
  float second;
  String timeString;
}

class Accel{
  float x;
  float y;
  float z;
}

class Gravity{
  float x;
  float y;
  float z;
}

class Gyro{
  float x;
  float y;
  float z;
}

class Quaternion {
  float x;
  float y;
  float z;
  float w;
}

class Pressure{
  float pressure;
  float altitude;
}

class Compass{
  boolean faceUp;
  float compass;
}

class GPS{
  float latitude;
  float longitude;
}

class TouchPoint{
  float x;
  float y;
  float radius;
  float force;
}

class Beacon {
  String uuid;
  int rssi;
  int major;
  int minor;
}

class ProximityMonitor {
  boolean proximityMonitor;
}

class MicLevel {
  float max;
  float average;
}

class RemoteControl {
  boolean playPause;
  boolean volumeUp;
  boolean volumeDown;
}