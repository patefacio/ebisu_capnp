library ebisu_capnp.test_factories;

import '../lib/capnp_schema.dart';
import 'package:ebisu/ebisu.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>
// end <additional imports>

part 'src/test_factories/name_constants.dart';
part 'src/test_factories/name_enums.dart';

final _logger = new Logger('test_factories');

// custom <library test_factories>
// end <library test_factories>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  testNamingEnums();
  testNamingConsts();

// end <main>
}
