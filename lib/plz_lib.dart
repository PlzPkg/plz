import "dart:io";
import "dart:js" deferred as js;
import "dart:async";

class Plz {
  final bool node;

  Plz({this.node: false});

  void init(String fileName, String name, String version) {
    print("init");
    var file;
    if (node) {
      print("doing work");
//      js.loadLibrary().then((_){

        print("library loaded");
      var test = js.context["console"];
      print("test: $test");
        throw new Exception("Can't write files yet");
//      }).catchError((e){
//        print(e.toString());
//      });
    } else {
      file = new File(fileName);
      if (!file.existsSync()) {
        file.createSync();
        file.writeAsStringSync("name: $name\nversion: $version");
      }
    }
  }
}