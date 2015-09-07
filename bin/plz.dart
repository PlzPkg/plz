#!/usr/bin/env dart

import "package:args/command_runner.dart";
import "package:plz/plz_lib.dart";
import "dart:io";
import "dart:js";
import "dart:async";
import "dart:convert";
import "package:node_io/io.dart" as nio;
import "package:node_io/util.dart" as niou;

main(List<String> args) {
  Plz plz = new Plz();

  new CommandRunner("plz", "A universal package manager")
  ..addCommand(new InitCommand(plz))
  ..run(args);
}

class InitCommand extends Command {

  final Plz plz;
  final name = "init";
  final description = "Initialize a new plz.yaml file";


  InitCommand(this.plz);

  run() async {
    var stdout = getStdOut();

    stdout.write("name: ");
    var name = await readLineFromStdIn();
    print("name was: $name");
    stdout.write("version: ");
    var version = await readLineFromStdIn();
    print("version: $version");
//    plz.init("plz.yaml", name, version);
  }

  getStdOut() {
    if (isNode()) {
      return new NodeStdOut();
    }
    return stdout;
  }

  Future<String> readLineFromStdIn() {
    Completer<String> completer = new Completer();
    if (isNode()) {
      var stdin = context["process"]["stdin"];
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

class NodeStdIn implements Stdin {

  String readLineSync({Encoding encoding: SYSTEM_ENCODING,
                      bool retainNewlines: false}) {
    print("in readLineSync");
    print("require: ${niou.require}");
    var readline = niou.require('readline');
    print("readline: $readline");

    var input = context["process"]["stdin"];
    print("input: $input");

    var output = context["process"]["stdout"];
    print("output: $output");

    var rl = readline.callMethod("createInterface", [{
      "input": input,
      "output": output,
      "terminal": false
    }]);
    print("rl: $rl");


    var callback = new JsFunction.withThis((cmd) {
      print('You just typed: '+cmd);
    });

    rl.callMethod('on', ['line', callback]);
    return "";
  }

  Future<List> get last {
    throw new Exception("not implemented");
  }


  Stream<List> distinct([bool equals(List previous, List next)]) {
    throw new Exception("not implemented");
  }


  void set lineMode(bool enabled) {
    throw new Exception("not implemented");
  }


  Future<List> elementAt(int index) {
    throw new Exception("not implemented");
  }


  Stream<List> take(int count) {
    throw new Exception("not implemented");
  }


  Future drain([futureValue]) {
    throw new Exception("not implemented");
  }


  Future<Set<List>> toSet() {
    throw new Exception("not implemented");
  }


  Stream asyncMap(convert(List event)) {
    throw new Exception("not implemented");
  }


  bool get echoMode {
    throw new Exception("not implemented");
  }


  Future<bool> every(bool test(List element)) {
    throw new Exception("not implemented");
  }


  Stream<List> handleError(Function onError, {bool test(error)}) {
    throw new Exception("not implemented");
  }


  void set echoMode(bool enabled) {
    throw new Exception("not implemented");
  }


  Stream<List> takeWhile(bool test(List element)) {
    throw new Exception("not implemented");
  }


  Future<List<List>> toList() {
    throw new Exception("not implemented");
  }


  Future<int> get length {
    throw new Exception("not implemented");
  }


  StreamSubscription<List<int>> listen(void onData(List<int> event), {Function onError, void onDone(), bool cancelOnError}) {
    throw new Exception("not implemented");
  }


  Stream timeout(Duration timeLimit, {void onTimeout(EventSink sink)}) {
    throw new Exception("not implemented");
  }


  Future<List> singleWhere(bool test(List element)) {
    throw new Exception("not implemented");
  }


  Future<dynamic> lastWhere(bool test(List element), {Object defaultValue()}) {
    throw new Exception("not implemented");
  }


  Future<List> get single {
    throw new Exception("not implemented");
  }


  Future<List> get first {
    throw new Exception("not implemented");
  }


  Stream<List> skipWhile(bool test(List element)) {
    throw new Exception("not implemented");
  }


  Future<bool> get isEmpty {
    throw new Exception("not implemented");
  }


  Future<bool> any(bool test(List element)) {
    throw new Exception("not implemented");
  }


  Future<bool> contains(Object needle) {
    throw new Exception("not implemented");
  }


  Future<String> join([String separator = ""]) {
    throw new Exception("not implemented");
  }


  Future fold(initialValue, combine(previous, List element)) {
    throw new Exception("not implemented");
  }


  Future<List> reduce(List combine(List previous, List element)) {
    throw new Exception("not implemented");
  }


  Stream expand(Iterable convert(List value)) {
    throw new Exception("not implemented");
  }


  Stream asyncExpand(Stream convert(List event)) {
    throw new Exception("not implemented");
  }


  Stream map(convert(List event)) {
    throw new Exception("not implemented");
  }


  Stream<List> asBroadcastStream({void onListen(StreamSubscription<List> subscription), void onCancel(StreamSubscription<List> subscription)}) {
    throw new Exception("not implemented");
  }


  Stream<List<int>> _stream() {
    throw new Exception("not implemented");
  }


  Stream<List> where(bool test(List event)) {
    throw new Exception("not implemented");
  }


  int readByteSync() {
    throw new Exception("not implemented");
  }


  Stream transform(StreamTransformer<List, dynamic> streamTransformer) {
    throw new Exception("not implemented");
  }


  Future pipe(StreamConsumer<List> streamConsumer) {
    throw new Exception("not implemented");
  }


  bool get isBroadcast {
    throw new Exception("not implemented");
  }


  bool get lineMode {
    throw new Exception("not implemented");
  }


  Future<dynamic> firstWhere(bool test(List element), {Object defaultValue()}) {
    throw new Exception("not implemented");
  }


  Stream<List> skip(int count) {
    throw new Exception("not implemented");
  }


  Future forEach(void action(List element)) {
    throw new Exception("not implemented");
  }
}

class NodeStdOut implements Stdout {

  void write(object) {
    context["process"]["stdout"].callMethod("write", [object]);
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

