library ebisu_capnp.test_schema;

import '../lib/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('test_schema');

// custom <library test_schema>
// end <library test_schema>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>
// end <main>
}
