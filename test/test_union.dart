library ebisu_capnp.test_union;

import '../lib/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'package:ebisu/ebisu.dart';

// end <additional imports>

final _logger = new Logger('test_union');

// custom <library test_union>
// end <library test_union>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  test('supports anonymous union', () {
    var s = struct('s')..fields = ['m1 1', 'm2 42 :Text', 'm3 @43 :Text'];
    s.unionize(['m1', 'm3']);
    expect(darkMatter(s.definition), darkMatter('''
struct s {
  union {
    m1 @1 :Int32;
    m3 @43 :Text;
  }
  m2 @42 :Text;
}
'''));
  });

  test('allows only one anonymous union', () {
    var s = struct('s')..fields = ['m1 1', 'm2 42 :Text', 'm3 @43 :Text'];
    s.unionize(['m1', 'm3']);

    /// Note: The following has no effect as m1 is already in the anonymous union
    s.unionize(['m1']);
    expect(darkMatter(s.definition), darkMatter('''
struct s {
  union {
    m1 @1 :Int32;
    m3 @43 :Text;
  }
  m2 @42 :Text;
}
'''));
  });

  test('supports named unions', () {
    var s = struct('s')..fields = ['m1 1', 'm2 42 :Text', 'm3 @43 :Text'];
    s.unionize(['m1', 'm3'], 'm1_and_m3');
    s.unionize(['m2'], 'just_m2');
    expect(darkMatter(s.definition), darkMatter('''
struct s {
  union m1_and_m3 {
    m1 @1 :Int32;
    m3 @43 :Text;
  }
  union just_m2 {
    m2 @42 :Text;
  }
}
'''));
  });

// end <main>
}
