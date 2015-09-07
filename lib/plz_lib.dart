import "dart:io";
import "dart:js" deferred as js;

class Plz {
  final bool node;

  Plz({this.node: false});

  init(String fileName, String name, String version) async {
    var file;
    if (node) {
      await js.loadLibrary();
      throw new Exception("Can't write files yet");
    } else {
      file = new File(fileName);
    }

    if (!file.existsSync()) {
      file.createSync();
      file.writeAsStringSync("name: $name\nversion: $version");
    }
  }
}