import "dart:io";

class Plz {
  init(String fileName, String name, String version) {
    var file = new File(fileName);
    if (!file.existsSync()) {
      file.createSync();
      file.writeAsStringSync("name: $name\nversion: $version");
    }
  }
}