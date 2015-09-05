#!/bin/bash
set -e

dartanalyzer lib/*.dart bin/*.dart
pub run test
if [ "$COVERALLS_TOKEN" ] && [ "$TRAVIS_DART_VERSION" = "stable" ]; then
    pub run dart_coveralls report --exclude-test-files test/*.dart