#!/usr/bin/env dart

import "package:args/command_runner.dart";
import "package:plz/plz_lib.dart";
import "dart:io";
import "dart:js" deferred as js;
import "dart:async";
import "dart:convert";

main(List<String> args) {

  var runArgs = args;
  var node = false;
  if (args.isNotEmpty && args.first == "--node") {
    node = true;
    runArgs = args.sublist(1);
  }
  Plz plz = new Plz(node: node);

  new CommandRunner("plz", "A universal package manager")
  ..addCommand(new InitCommand(plz))
  ..run(runArgs);
}

class InitCommand extends Command {

  final Plz plz;
  final name = "init";
  final description = "Initialize a new plz.yaml file";


  InitCommand(this.plz);

  run() async {
    if (plz.node) {
      await js.loadLibrary();
    }

    var stdout = await getStdOut();

    stdout.write("name: ");
    var name = await readLineFromStdIn();
    stdout.write("version: ");
    var version = await readLineFromStdIn();
    await plz.init("plz.yaml", name, version);
  }

  getStdOut() async {
    if (plz.node) {
      return new NodeStdOut();
    }
    return stdout;
  }

  Future<String> readLineFromStdIn() {
    Completer<String> completer = new Completer();
    if (plz.node) {
      var stdin = js.context["process"]["stdin"];
      stdin.callMethod("setEncoding", ['utf8']);

      var readableCallback = () {
        var chunk = stdin.callMethod("read");
        completer.complete(chunk);
      };
      stdin.callMethod("once", ['readable', readableCallback]);
    } else {
      var line = stdin.readLineSync();
      completer.complete(line);
    }
    return completer.future;
  }
}

class NodeStdOut implements Stdout {

  void write(object) {
    js.context["process"]["stdout"].callMethod("write", [object]);
  }

  int _fd() {
    throw new Exception("not implemented");
  }

  IOSink get nonBlocking {
    throw new Exception("not implemented");
  }


  int _terminalLines(int fd) {
    throw new Exception("not implemented");
  }


  int _terminalColumns(int fd) {
    throw new Exception("not implemented");
  }


  bool _hasTerminal(int fd) {
    throw new Exception("not implemented");
  }


  int get terminalLines {
    throw new Exception("not implemented");
  }


  int get terminalColumns {
    throw new Exception("not implemented");
  }


  bool get hasTerminal {
    throw new Exception("not implemented");
  }


  IOSink _nonBlocking() {
    throw new Exception("not implemented");
  }

  Future get done {
    throw new Exception("not implemented");
  }


  Future close() {
    throw new Exception("not implemented");
  }


  Future flush() {
    throw new Exception("not implemented");
  }


  Future addStream(Stream<List<int>> stream) {
    throw new Exception("not implemented");
  }


  void writeCharCode(int charCode) {
    throw new Exception("not implemented");
  }


  void addError(error, [StackTrace stackTrace]) {
    throw new Exception("not implemented");
  }


  void add(List<int> data) {
    throw new Exception("not implemented");
  }


  void writeAll(objects, [sep = ""]) {
    throw new Exception("not implemented");
  }


  void writeln([object = ""]) {
    throw new Exception("not implemented");
  }


  void set encoding(Encoding encoding) {
    throw new Exception("not implemented");
  }


  Encoding get encoding {
    throw new Exception("not implemented");
  }


  IOSink _sink() {
    throw new Exception("not implemented");
  }
}

