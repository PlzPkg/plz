#!/usr/bin/env dart

import "package:args/command_runner.dart";
import "package:plz/plz_lib.dart";
import "dart:io";

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

  run() {
    stdout.write("name: ");
    var name = stdin.readLineSync();
    stdout.write("version: ");
    var version = stdin.readLineSync();
    plz.init("plz.yaml", name, version);
  }
}