library ebisu_capnp.test_enum;

import '../lib/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'package:ebisu/ebisu.dart';

// end <additional imports>

final _logger = new Logger('test_enum');

// custom <library test_enum>
// end <library test_enum>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  test('enum definition - default indices', () {
    final e = enum_('color')..values = ['red', 'green', 'blue'];

    expect(
        darkSame(
            e.definition,
            '''
enum color {
  red @0;
  green @1;
  blue @2;
}
'''),
        true);
  });

  test('enum definition - managed indices', () {
    final e = enum_('color')
      ..values = [
        enumValue('red', 3),
        enumValue('green', 6),
        enumValue('blue', 9),
      ];

    expect(
        darkSame(
            e.definition,
            '''
enum color {
  red @3;
  green @6;
  blue @9;

}
'''),
        true);
  });

// end <main>
}
