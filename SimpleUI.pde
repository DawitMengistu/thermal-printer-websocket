import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

class SimpleUI {
  
  JFrame frame;
  JComboBox<String> printerComboBox;
  JButton testButton;
  JButton saveButton;
  
  SimpleUI() {
    createUI();
  }
  
  void createUI() {
    frame = new JFrame("Simple Printer Control");
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setSize(400, 200);
    frame.setLayout(null);
    
    // Printer selection label
    JLabel label = new JLabel("Select Printer:");
    label.setBounds(20, 20, 100, 20);
    
    // Printer dropdown
    printerComboBox = new JComboBox<>(printServicesNames);
    printerComboBox.setBounds(20, 50, 350, 25);
    printerComboBox.setSelectedItem(printerName);
    
    // Test print button
    testButton = new JButton("Print Test");
    testButton.setBounds(20, 90, 100, 30);
    testButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        printerName = printerComboBox.getSelectedItem().toString();
        simplePrinter.printTest();
      }
    });
    
    // Save settings button
    saveButton = new JButton("Save Settings");
    saveButton.setBounds(140, 90, 100, 30);
    saveButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        printerName = printerComboBox.getSelectedItem().toString();
        simpleFile.saveSelectedPrinter(printerName);
        JOptionPane.showMessageDialog(frame, "Printer settings saved!");
      }
    });
    
    // Add components to frame
    frame.add(label);
    frame.add(printerComboBox);
    frame.add(testButton);
    frame.add(saveButton);
    
    // Center frame on screen
    frame.setLocationRelativeTo(null);
    frame.setResizable(false);
    frame.setVisible(true);
  }
}

