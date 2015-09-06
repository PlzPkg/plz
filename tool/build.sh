#!/bin/bash
set -e

dartanalyzer lib/*.dart bin/*.dart
pub run test
if [ "$COVERALLS_TOKEN" ] && [ "$TRAVIS_DART_VERSION" = "stable" ]; then
    pub run dart_coveralls report --exclude-test-files test/plz_lib_test.dart
fi
dart2js --categories=Server bin/plz.dart
cat $DART_SDK/lib/_internal/js_runtime/lib/preambles/d8.js out.js >> node.js