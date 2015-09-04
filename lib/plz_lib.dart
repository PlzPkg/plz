import "dart:io";

class Plz {
  init(String fileName) {
    var file = new File(fileName);
    file.createSync();
  }
}