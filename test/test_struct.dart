library ebisu_capnp.test_struct;

import '../lib/capnp_schema.dart';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'package:ebisu/ebisu.dart';

// end <additional imports>

final _logger = new Logger('test_struct');

// custom <library test_struct>
// end <library test_struct>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  group('member', () {
    test('members are numbered', () {
      final m = member('m', 1)..type = textT;
      expect(m.definition, 'm @1 :Text;');
    });
  });

  group('struct', () {
    test('structs can be empty', () {
      final s = struct('s');
      expect(darkMatter(s.definition), darkMatter('struct S { }'));
    });

    test('structs have numbered members defaulted to Int32', () {
      final s = struct('s')..members = [member('m1', 1), member('m2', 2),];
      expect(darkMatter(s.definition),
          darkMatter('struct S { m1 @1 :Int32; m2 @2 :Int32; }'));
    });

    test('struct *members* assign accepts member', () {
      final s = struct('s')
        ..members = [member('m1', 1), member('m2', 42, textT),];
      expect(darkMatter(s.definition),
          darkMatter('struct S{ m1 @1 :Int32; m2 @42 :Text;}'));
    });

    test('struct *members* assign accepts strings', () {
      var s = struct('s')..members = ['m1 1', 'm2 42 :Text', 'm3 @43 :Text'];
      expect(darkMatter(s.definition),
          darkMatter('struct S{ m1 @1 :Int32; m2 @42 :Text; m3 @43 :Text;}'));
    });
  });

// end <main>

}
