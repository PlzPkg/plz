#!/usr/bin/env node
function dartMainRunner(main, args) {
    global.dartMainRunner(main, process.argv.slice(2));
}
