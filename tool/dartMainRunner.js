#!/usr/bin/env node
function dartMainRunner(main, args) {
    var newArgs = process.argv.slice(2);
    newArgs.unshift("--node");
    global.dartMainRunner(main, newArgs);
}

function load(uri) {
    var fs = require("fs");
    var vm = require("vm");
    var contents = fs.readFileSync("bin/" + uri, {encoding: "utf8"});
    vm.runInThisContext(contents);
}