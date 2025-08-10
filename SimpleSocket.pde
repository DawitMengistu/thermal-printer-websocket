import websockets.*;


class SimpleSocket {
  SimplePrinter printer;
  WebsocketServer ws;
  PApplet sketch;

  SimpleSocket(PApplet sketch, SimplePrinter printer) {
    this.sketch = sketch;
    this.printer = printer;
    // Start websocket server on port 6969
    ws = new WebsocketServer(sketch, 6969, "/print");
  }

  // Handle incoming websocket messages
  void handleMessage(String msg) {
    try {
      JSONObject data = parseJSONObject(msg);
      String command = data.getString("command");

      switch(command) {
      case "printText":
        String text = data.getString("text");
        printer.printText(text);
        break;

      case "printImage":
        String imagePath = data.getString("imagePath");
        printer.printImage(imagePath);
        break;

      case "printImageAndText":
        String imgPath = data.getString("imagePath");
        String txt = data.getString("text");
        printer.printImageAndText(imgPath, txt);
        break;

      case "printTest":
        printer.printTest();
        break;

      default:
        println("Unknown command: " + command);
        break;
      }
    }
    catch (Exception e) {
      println("Socket error: " + e);
    }
  }

  // Send message to connected clients
  void sendMessage(String message) {
    if (ws != null) {
      ws.sendMessage(message);
    }
  }
}
