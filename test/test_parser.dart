library ebisu_capnp.test_parser;

import '../lib/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'package:ebisu_capnp/capnp_parser.dart';
import 'package:ebisu/ebisu.dart';
import 'package:petitparser/debug.dart';

// end <additional imports>

final _logger = new Logger('test_parser');

// custom <library test_parser>
// end <library test_parser>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  Logger.root.level = Level.INFO;
  group('parse basic schema', () {
    final parser = new CapnpParser();

    final snippets = {
      'void': '''
struct F { x @1 :Void; }
''',
      'empty': '',
      'struct': '''
struct foo {

  abce @1 :int;

}
''',
      'listType': '''
struct foo {
  abc @1 :List(Int32);
}
''',
      'listOfListType': '''
struct foo {
  abc @1 :List(List(Int32));
}
''',
      'litstr': '[   true,  false ]\n',
      'list ints': '[ 1, 2222222222, 3, -2 ]\n',
      'list floats': '[ 1.0, -3.14, 2., 1.222222, 2., 0.00000001 ]\n',
      'member with list string assign': '''
struct foo {
  abc @1 :string = "abra";
}
''',
      'member with int assign': '''
struct foo {
  abc @1 :Int = 42;
}
''',
      'member with list init size 4': '''
struct foo {
  abc @1 :List(string) = [ "abra", "b", "z", "goo" ];
}
''',
      'member with list init size 1': '''
struct foo {
  abc @1 :string = [ "abra" ];
}
''',
      'member with list size 0': '''
struct foo {
  abc @1 :string = [];
}
''',
      'struct with enum': '''
struct Foo { enum Goo { a @1; b @1; } }
''',
      'struct with union': '''
struct Foo { union X { abc @1 :int; } }
''',
      'nestedStruct': '''
struct Foo { struct Goo { a @1 :int; } }
''',
      'union': '''
union X { abc @1 : int; }
''',
      'unnamed union': '''
union { abc @1 : int; }
''',
      'empty enum': '''
enum foo { # bam
# bam
}
''',
      'enum': '''
enum Operator {
    add @0;          ##
    subtract @1;   #
    multiply @2;  #
    divide @3;     ######
}
''',
      'method no args no return': 'foo @1 () -> ();',
      'method one arg': 'foo @1 (arg1 :arg1) -> ();',
      'method': '''
foo @1 (x :goo, y :moob) -> (goo :Int32) ;
''',
      'using = name': 'using T = Foo',
      'using = qualifiedName': 'using T = Foo.Bar',
      'interface': 'interface Foo {}',
      'nested interface': 'interface Foo { interface Goo { }}',
      'interface/enum': 'interface Foo { enum Goo { }}',
      'interface with method': '''
interface IF {
  foo @1 (arg1Name :arg1Type, arg2Name :arg2Type, arg3Name :arg3Type) -> (result :List(Int32));
}
'''
    };

    snippets.keys
        //        .where((tag) => tag.contains('init size 4'))
        .forEach((String tag) {
      final text = snippets[tag];
      test(tag, () {
        _logger.info(
            '\n-----------------------($tag)-----------------------------\n'
            '${indentBlock(text)}');
        _logger.info(text);
        expect(parser.accept(text), true);
      });
    });
  });

// end <main>
}
