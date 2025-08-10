import com.github.anastaciocintra.escpos.EscPos;
import com.github.anastaciocintra.escpos.EscPosConst;
import com.github.anastaciocintra.escpos.Style;
import com.github.anastaciocintra.escpos.image.*;
import com.github.anastaciocintra.output.PrinterOutputStream;

import java.awt.image.BufferedImage;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.print.PrintService;
import java.awt.Graphics2D;
import java.awt.Color;

class SimplePrinter {
  
  // Convert PImage to BufferedImage
  BufferedImage pImageToBufferedImage(PImage pimg) {
    BufferedImage bufferedImage = new BufferedImage(pimg.width, pimg.height, BufferedImage.TYPE_INT_RGB);
    bufferedImage.createGraphics().drawImage(pimg.getImage(), 0, 0, null);
    return bufferedImage;
  }
  
  // Basic text printing
  void printText(String text) {
    try {
      PrintService printService = PrinterOutputStream.getPrintServiceByName(printerName);
      PrinterOutputStream printerOutputStream = new PrinterOutputStream(printService);
      EscPos escpos = new EscPos(printerOutputStream);
      
      escpos.write(text).feed(10).cut(EscPos.CutMode.FULL);
      escpos.close();
    } catch (Exception e) {
      println("Print error: " + e);
    }
  }
  
  // Print image with text
  void printImageAndText(String imagePath, String text) {
    try {
      PrintService printService = PrinterOutputStream.getPrintServiceByName(printerName);
      PrinterOutputStream printerOutputStream = new PrinterOutputStream(printService);
      EscPos escpos = new EscPos(printerOutputStream);
      
      // Load image using Processing's loadImage (handles data folder automatically)
      PImage pimg = loadImage(imagePath);
      if (pimg == null) {
        println("Error: Could not load image: " + imagePath);
        return;
      }
      
      // Convert PImage to BufferedImage
      BufferedImage bufferedImage = pImageToBufferedImage(pimg);
      
      // Process image for printing
      Bitonal algorithm = new BitonalThreshold(127);
      EscPosImage escposImage = new EscPosImage(new CoffeeImageImpl(bufferedImage), algorithm);
      
      // Image wrapper
      RasterBitImageWrapper imageWrapper = new RasterBitImageWrapper();
      imageWrapper.setJustification(EscPosConst.Justification.Center);
      
      // Print image then text
      escpos.write(imageWrapper, escposImage)
            .feed(2)
            .write(text)
            .feed(10)
            .cut(EscPos.CutMode.FULL);
      
      escpos.close();
      println("Successfully printed image with text: " + imagePath);
    } catch (Exception e) {
      println("Print error: " + e);
    }
  }
  
  // Print image only
  void printImage(String imagePath) {
    try {
      PrintService printService = PrinterOutputStream.getPrintServiceByName(printerName);
      PrinterOutputStream printerOutputStream = new PrinterOutputStream(printService);
      EscPos escpos = new EscPos(printerOutputStream);
      
      // Load image using Processing's loadImage (handles data folder automatically)
      PImage pimg = loadImage(imagePath);
      if (pimg == null) {
        println("Error: Could not load image: " + imagePath);
        return;
      }
      
      // Convert PImage to BufferedImage
      BufferedImage bufferedImage = pImageToBufferedImage(pimg);
      
      // Process image for printing
      Bitonal algorithm = new BitonalThreshold(127);
      EscPosImage escposImage = new EscPosImage(new CoffeeImageImpl(bufferedImage), algorithm);
      
      // Image wrapper
      RasterBitImageWrapper imageWrapper = new RasterBitImageWrapper();
      imageWrapper.setJustification(EscPosConst.Justification.Center);
      
      // Print image
      escpos.write(imageWrapper, escposImage)
            .feed(10)
            .cut(EscPos.CutMode.FULL);
      
      escpos.close();
      println("Successfully printed image: " + imagePath);
    } catch (Exception e) {
      println("Print error: " + e);
    }
  }
  
  // Test print
  void printTest() {
    try {
      PrintService printService = PrinterOutputStream.getPrintServiceByName(printerName);
      PrinterOutputStream printerOutputStream = new PrinterOutputStream(printService);
      EscPos escpos = new EscPos(printerOutputStream);
      
      // Print test text
      escpos.write("=== PRINTER TEST ===").feed(1)
            .write("Printer: " + printerName).feed(1)
            .write("Status: Working").feed(1)
            .write("Time: " + str(hour()) + ":" + str(minute()) + ":" + str(second())).feed(2);
      
      // Try to print a test image if available
      try {
        PImage testImg = loadImage("logo.png");
        if (testImg != null) {
          // Convert PImage to BufferedImage
          BufferedImage bufferedImage = pImageToBufferedImage(testImg);
          
          // Process image for printing
          Bitonal algorithm = new BitonalThreshold(127);
          EscPosImage escposImage = new EscPosImage(new CoffeeImageImpl(bufferedImage), algorithm);
          
          // Image wrapper
          RasterBitImageWrapper imageWrapper = new RasterBitImageWrapper();
          imageWrapper.setJustification(EscPosConst.Justification.Center);
          
          // Print test image
          escpos.write(imageWrapper, escposImage).feed(2);
          println("Test image printed successfully");
        } else {
          escpos.write("Test image: Not available").feed(2);
        }
      } catch (Exception imgError) {
        escpos.write("Test image: Error loading").feed(2);
        println("Image test error: " + imgError);
      }
      
      // Final feed and cut
      escpos.feed(10).cut(EscPos.CutMode.FULL);
      escpos.close();
      println("Test print completed successfully");
    } catch (Exception e) {
      println("Test print error: " + e);
    }
  }
}

