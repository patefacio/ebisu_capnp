library ebisu_capnp.test_constant;

import '../lib/capnp_schema.dart';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('test_constant');

// custom <library test_constant>
// end <library test_constant>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  test('const', () {
    final c = const_('color', int32T, '32');
    print(c.definition);
  });

// end <main>

}
