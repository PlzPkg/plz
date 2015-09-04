import "package:test/test.dart";
import "dart:io";
import "package:plz/plz_lib.dart";

main() {
  group("init", (){
    test("creates a plz.yaml file", (){
      final fileName = "test/plz.yaml";
      var file = new File(fileName);
      if (file.existsSync()) {
        file.deleteSync();
      }

      expect(file.existsSync(), isFalse);

      Plz plz = new Plz();
      plz.init(fileName);

      expect(file.existsSync(), isTrue);
    });
  });
}