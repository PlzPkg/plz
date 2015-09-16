#!/usr/bin/env node

var path = require("path");
var execSync = require("child_process").execSync;

var dartPath = path.join(__dirname, "../dart-sdk/bin/dart");
if (process.platform === "linux" || process.platform === "darwin") {
    execSync("chmod +x " + dartPath, {
        stdio: [
            0, // use parents stdin for child
            1, // use parents stdout for child
            2 // use parents stderr for child
        ]
    });
}

var plzPath = path.join(__dirname, "plz.dart");
var args = process.argv.splice(2).join(' ');
var command =  dartPath + " " + plzPath + " " + args;
execSync(command, {
    stdio: [
        0, // use parents stdin for child
        1, // use parents stdout for child
        2 // use parents stderr for child
    ]
});