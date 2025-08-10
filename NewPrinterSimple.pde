import com.github.anastaciocintra.output.PrinterOutputStream;

// Global variables
String printerName = "Generic / Text Only (Copy 1)";
String[] printServicesNames = PrinterOutputStream.getListPrintServicesNames();

// Component instances
SimplePrinter simplePrinter;
SimpleSocket simpleSocket;
SimpleUI simpleUI;
SimpleFile simpleFile;

void setup() {
  // Initialize components
  simplePrinter = new SimplePrinter();
  simpleFile = new SimpleFile();
  simpleUI = new SimpleUI();
  simpleSocket = new SimpleSocket(this, simplePrinter);
  
  // Load saved printer settings
  simpleFile.loadFile();
  
  // Hide Processing window since we're using Swing UI
  surface.setVisible(false);
  
  println("=== NEW PRINTER SIMPLE ===");
  println("WebSocket server running on port 6969");
  println("Available commands:");
  println("- printText: Print text only");
  println("- printImage: Print image only");
  println("- printImageAndText: Print image with text");
  println("- printTest: Print test page");
}

void draw() {
  // Empty draw loop - everything handled by Swing UI and WebSocket
}

// WebSocket event handler (required for websockets library)
void webSocketServerEvent(String msg) {
  simpleSocket.handleMessage(msg);
}

void exit() {
  if (simpleUI.frame != null) {
    simpleUI.frame.dispose();
  }
}

/*
USAGE EXAMPLES:

1. LOCAL TESTING (using UI buttons):
   - Select printer from dropdown
   - Click "Print Test" to test printer
   - Click "Save Settings" to save printer selection

2. WEBSOCKET COMMANDS (send JSON to port 6969):
   
   Print text only:
   {"command": "printText", "text": "Hello World!"}
   
   Print image only:
   {"command": "printImage", "imagePath": "data/logo.png"}
   
   Print image with text:
   {"command": "printImageAndText", "imagePath": "data/logo.png", "text": "Company Logo"}
   
   Print test page:
   {"command": "printTest"}

3. PROGRAMMATIC USAGE:
   simplePrinter.printText("Hello");
   simplePrinter.printImage("data/logo.png");
   simplePrinter.printImageAndText("data/logo.png", "Logo with text");
   simplePrinter.printTest();

4. SOCKET COMMUNICATION:
   simpleSocket.sendMessage("Status: Ready");
*/

