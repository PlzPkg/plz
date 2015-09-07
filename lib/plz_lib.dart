import "dart:io";
import "package:node_io/io.dart" as nio;
import "dart:js";

isNode() {
  return context["process"] != null;
}

class Plz {
  init(String fileName, String name, String version) {
    var file;
    if (isNode()) {
      file = new nio.File(fileName);
    } else {
      file = new File(fileName);
    }

    if (!file.existsSync()) {
      file.createSync();
      file.writeAsStringSync("name: $name\nversion: $version");
    }
  }
}