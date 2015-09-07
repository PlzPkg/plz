#!/bin/bash
set -e

#dartanalyzer lib/*.dart bin/*.dart
#pub run test
if [ "$COVERALLS_TOKEN" ] && [ "$TRAVIS_DART_VERSION" = "stable" ]; then
    pub run dart_coveralls report --exclude-test-files test/plz_lib_test.dart
fi
dart2js --categories=all -o bin/plz.dart.js bin/plz.dart
cat tool/dartMainRunner.js $DART_SDK/lib/_internal/js_runtime/lib/preambles/d8.js bin/plz.dart.js >> bin/plz.js
