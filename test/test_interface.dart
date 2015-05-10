library ebisu_capnp.test_interface;

import '../lib/capnp_schema.dart';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('test_interface');

// custom <library test_interface>
// end <library test_interface>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>
// end <main>

}
