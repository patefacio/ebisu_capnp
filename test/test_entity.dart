library ebisu_capnp.test_entity;

import '../lib/capnp_schema.dart';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('test_entity');

// custom <library test_entity>
// end <library test_entity>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>
// end <main>

}
