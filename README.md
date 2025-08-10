# NewPrinterSimple

A simplified thermal printer control system with WebSocket support for printing images and text.

## Features

- **SimplePrinter**: Basic printing functions for text and images
- **SimpleSocket**: WebSocket server for remote printing commands
- **SimpleUI**: Simple Swing interface for printer selection and testing
- **SimpleFile**: File handling for saving printer settings


<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/b602a7cb-9cd9-4678-ade4-c7be86069434" width="300"/></td>
    <td><img src="https://github.com/user-attachments/assets/bd3e537a-8788-4ac5-81ed-efd39d15c9d5" width="300"/></td>
    <td><img src="https://github.com/user-attachments/assets/210a474e-a0b8-48dc-90a1-9f9c5e12726e" width="300" /></td>
  </tr>
</table>




## Setup

1. Make sure you have the Processing IDE installed
2. Install the WebSockets library: `Sketch > Import Library > Add Library > WebSockets`
3. Copy the `escpos-coffee-4.1.0.jar` to your Processing libraries folder or add it to the sketch

## Usage

### Local Testing

1. Run the sketch
2. Select your printer from the dropdown and Save, You must first add printer on you system to select it
3. Click "Print Test" to test the printer
4. Click "Save Settings" to save your printer selection

### WebSocket Commands

Send JSON commands to `ws://localhost:6969/print`:

```json
Print text only
{"command": "printText", "text": "Hello World!"}

Print image only
{"command": "printImage", "imagePath": "data/logo.png"}

Print image with text
{"command": "printImageAndText", "imagePath": "data/logo.png", "text": "Company Logo"}

// Print test page
{"command": "printTest"}
```

### Programmatic Usage

```java
simplePrinter.printText("Hello");
simplePrinter.printImage("data/logo.png");
simplePrinter.printImageAndText("data/logo.png", "Logo with text");
simplePrinter.printTest();
```

## Dependencies

- Processing IDE
- WebSockets library
- ESC/POS library (escpos-coffee-4.1.0.jar)
