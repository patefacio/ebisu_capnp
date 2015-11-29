library ebisu_capnp.test_parser;

import 'package:ebisu_capnp/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'dart:io';
import 'package:path/path.dart';
import 'package:ebisu_capnp/capnp_parser.dart';
import 'package:ebisu/ebisu.dart';
import 'package:petitparser/debug.dart';

// end <additional imports>

part 'src/test_parser/parse_enum.dart';
part 'src/test_parser/parse_import.dart';
part 'src/test_parser/parse_interface.dart';
part 'src/test_parser/parse_literal.dart';
part 'src/test_parser/parse_method.dart';
part 'src/test_parser/parse_struct.dart';
part 'src/test_parser/parse_type.dart';
part 'src/test_parser/parse_union.dart';
part 'src/test_parser/parse_using.dart';

final _logger = new Logger('test_parser');

// custom <library test_parser>
// end <library test_parser>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  Logger.root.level = Level.OFF;
  parseImportTests();
  parseTypeTests();
  parseLiteralTests();
  parseUsingTests();
  parseEnumTests();
  parseUnionTests();
  parseStructTests();
  parseMethodTests();
  parseInterfaceTests();

  final here = dirname(absolute(Platform.script.toFilePath()));
  final schemaDir = new Directory(join(here, 'schemas'));
  final parser = new CapnpParser();
  schemaDir.listSync(recursive:true, followLinks:false).forEach((FileSystemEntity f) {
    if(f.path.endsWith('schema.capnp') && FileSystemEntity.isFileSync(f.path)) {
      final capnp = new File(f.path).readAsStringSync();
      print(parser.parse(capnp));
      //print('Processing $f\n----------------------\n$capnp');
    }
  });


// end <main>
}
