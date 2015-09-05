import "package:test/test.dart";
import "dart:io";
import 'package:yaml/yaml.dart';


_callPlzInit(name, version) async {
  Process process = await Process.start("../bin/plz.dart", ["init"], workingDirectory: "test");
  await for (var data in process.stdout) {
    String line = new String.fromCharCodes(data);
    if (line == "name: ") {
      process.stdin.writeln(name);
      await process.stdin.flush();
    } else if (line == "version: ") {
      process.stdin.write(version);
      await process.stdin.close();
      //Note: close must be called after the last user input is asked for.
    } else {
      fail("Unexpected message on stdout: " + line);
    }
  }
}

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

        await _callPlzInit(name, version);
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
        await _callPlzInit('Some other package', '0.0.1');

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