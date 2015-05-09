library ebisu_capnp.test_generic;

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('test_generic');

// custom <library test_generic>
// end <library test_generic>

main([List<String> args]) {
  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>
// end <main>


}


