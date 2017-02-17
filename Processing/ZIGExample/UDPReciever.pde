import processing.core.*;
import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.io.IOException;
import java.lang.reflect.*;
  
public class UDPReceiever {
  PApplet parent;
  Method recieveMessageMethod;
  String message;
  int port;
  DatagramSocket socket;
  DatagramPacket packet;
  public static final int PACKET_SIZE = 1024;
  
  public void setup(PApplet parent, int SERVER_PORT) {
    port = SERVER_PORT;
    //message = new String();
    this.parent = parent;
    socket = null;
  }
  
  public void run() {
    
    byte[] buf = new byte[PACKET_SIZE];
    packet = new DatagramPacket(buf, buf.length);
    try {
      socket = new DatagramSocket(port);
      //System.out.println("DatagramReceiver(port="
      //                   + socket.getLocalPort() + ")");
      while (true) {
        socket.receive(packet);
        message = new String(buf, 0, packet.getLength());
        //System.out.println(packet.getSocketAddress()
        //                   + ":" + message);
         try {
           parent.getClass().getMethod(
          "recieveMessage",
          new Class[] {UDPReceiever.class}).invoke(parent, new Object[]{ this });
         } catch (ReflectiveOperationException e) {
             throw new RuntimeException(e);
         }
      }
    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      if (socket != null) {
        socket.close();
      }
    }
  }
}