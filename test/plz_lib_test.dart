import "package:test/test.dart";
import "dart:io";
import 'package:yaml/yaml.dart';
import "package:plz/plz_lib.dart";

main() {
  group("init", () {

    group("generates a yaml file", () {
      final fileName = "test/plz.yaml";
      final name = "Test Package";
      final version = "1.0.0";
      var file = new File(fileName);

      setUp(() async {
        if (file.existsSync()) {
          file.deleteSync();
        }
        expect(file.existsSync(), isFalse);

        Plz plz = new Plz();
        plz.init(fileName, name, version);
      });

      test("with the specified file name", () {
        expect(file.existsSync(), isTrue);
      });

      test("with the specified package name", () {
        var fileContents = file.readAsStringSync();
        var doc = loadYaml(fileContents);
        expect(doc["name"], equals(name));
      });

      test("with the specified version", () {
        var fileContents = file.readAsStringSync();
        var doc = loadYaml(fileContents);
        expect(doc["version"], equals("1.0.0"));
      });

      test("unless the file already exists", () async {
        Plz plz = new Plz();
        plz.init(fileName, 'Some other package', '0.0.1');

        var fileContents = file.readAsStringSync();
        var doc = loadYaml(fileContents);
        expect(doc["name"], equals(name));
        expect(doc["version"], equals("1.0.0"));
      });

      tearDown(() {
        if (file.existsSync()) {
          file.deleteSync();
        }
        expect(file.existsSync(), isFalse);
      });

    });

  });
}