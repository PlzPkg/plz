#!/bin/bash
set -e

dartanalyzer lib/*.dart bin/*.dart
if [ "$COVERALLS_TOKEN" ] && [ "$TRAVIS_DART_VERSION" = "stable" ]; then
    dart --observe=2000 test/*.dart &
    pub global activate coverage
    pub global run coverage:collect_coverage --port=2000 -o report/coverage.json --resume-isolates
    pub run dart_coveralls upload --exclude-test-files report
else
    pub run test
fi
dart2js --categories=Server bin/plz.dart
cat $DART_SDK/lib/_internal/js_runtime/lib/preambles/d8.js out.js >> node.js