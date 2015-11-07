library ebisu_capnp.test_parser;

import '../lib/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

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

  Logger.root.level = Level.WARNING;
  parseImportTests();
  parseTypeTests();
  parseLiteralTests();
  parseUsingTests();
  parseEnumTests();
  parseUnionTests();
  parseStructTests();
  parseMethodTests();
  parseInterfaceTests();

// end <main>
}
