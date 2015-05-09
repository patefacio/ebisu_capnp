library ebisu_capnp.test_enum;

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('test_enum');

// custom <library test_enum>
// end <library test_enum>

main([List<String> args]) {
  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>
// end <main>


}


