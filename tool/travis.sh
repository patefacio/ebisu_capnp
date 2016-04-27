#!/bin/bash

# Fast fail the script on failures.
set -e

# Skipping this until at least we have a dev release that aligns with dart_style version
# $(dirname -- "$0")/ensure_dartfmt.sh

# Run the tests.
dart test/runner.dart

#### Not found in travis
#/usr/lib/dart/bin/dartanalyzer lib/*.dart test/*.dart
