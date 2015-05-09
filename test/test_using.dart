library ebisu_capnp.test_using;

import '../lib/capnp_schema.dart';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';

// custom <additional imports>
import 'package:ebisu/ebisu.dart';
// end <additional imports>

final _logger = new Logger('test_using');

// custom <library test_using>
// end <library test_using>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  test('Simple Using', () {
    final u = new Using('Foo.Goo');
    expect(darkSame(u.definition, 'using Foo.Goo;'), true);
  });

  test('AliasUsing', () {
    final au = new AliasUsing('foobar', 'Foo.Bar')..doc = 'Confusing';
    expect(darkSame(au.definition, '''
using Foobar_t = Foo.Bar;
  #  Confusing
'''), true);
  });

// end <main>

}
