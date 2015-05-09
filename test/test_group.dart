library ebisu_capnp.test_group;

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('test_group');

// custom <library test_group>
// end <library test_group>

main([List<String> args]) {
  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>
// end <main>


}


