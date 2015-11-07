library hop_runner;

import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
import 'package:hop_docgen/hop_docgen.dart';
import 'package:path/path.dart' as path;
import '../test/runner.dart' as runner;

void main(List<String> args) {
  Directory.current = path.dirname(path.dirname(Platform.script.toFilePath()));

  addTask('analyze_lib', createAnalyzerTask(_getLibs));
  //TODO: Figure this out: addTask('docs', createDocGenTask(_getLibs));
  addTask(
      'analyze_test',
      createAnalyzerTask([
        "test/test_type.dart",
        "test/test_entity.dart",
        "test/test_using.dart",
        "test/test_struct.dart",
        "test/test_union.dart",
        "test/test_group.dart",
        "test/test_interface.dart",
        "test/test_generic.dart",
        "test/test_constant.dart",
        "test/test_import.dart",
        "test/test_annotation.dart",
        "test/test_schema.dart",
        "test/test_parser.dart",
        "test/test_factories.dart"
      ]));

  runHop(args);
}

Future<List<String>> _getLibs() {
  return new Directory('lib')
      .list()
      .where((FileSystemEntity fse) => fse is File)
      .map((File file) => file.path)
      .toList();
}
