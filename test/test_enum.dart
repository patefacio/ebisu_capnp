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
    final e = enum_('color')
      ..doc = 'Establishes the beest colors'
      ..values = ['red', 'green', 'blue'];

    expect(
        darkSame(
            e.definition,
            '''
enum Color {
  #  Establishes the beest colors
  Red_e @0;
  Green_e @1;
  Blue_e @2;
}
'''),
        true);
  });

  test('enum definition - managed indices', () {
    final e = enum_('color')
      ..doc = 'Establishes the beest colors'
      ..values = [
        enumValue('red', 3)..doc = 'The color of blood',
        enumValue('green', 6)..doc = 'The color of grass',
        enumValue('blue', 9)..doc = 'The color of the sky',
      ];

    expect(
        darkSame(
            e.definition,
            '''
enum Color {
  #  Establishes the beest colors
  Red_e @3;
    #  The color of blood
  Green_e @6;
    #  The color of grass
  Blue_e @9;
    #  The color of the sky
}
'''),
        true);
  });

// end <main>
}
