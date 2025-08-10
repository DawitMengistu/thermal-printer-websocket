class SimpleFile {
  
  void loadFile() {
    try {
      String[] savedPrinter = loadStrings("data/data.txt");
      if (checkName(printServicesNames, savedPrinter[0])) {
        printerName = savedPrinter[0];
      } else if (printServicesNames.length > 0) {
        String[] list = split(printServicesNames[0], '\n');
        saveStrings("data/data.txt", list);
      } else {
        String[] list = split(" ", '\n');
        saveStrings("data/data.txt", list);
      }
    } catch (Exception e) {
      String[] list = split(printerName, '\n');
      saveStrings("data/data.txt", list);
    }
  }
  
  void saveSelectedPrinter(String printerName) {
    String[] list = split(printerName, '\n');
    saveStrings("data/data.txt", list);
  }
  
  boolean checkName(String[] myArray, String searchValue) {
    for (int i = 0; i < myArray.length; i++) {
      if (myArray[i].equals(searchValue)) {
        return true;
      }
    }
    return false;
  }
}

