library ebisu_capnp.test_parser;

import '../lib/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'package:ebisu_capnp/capnp_parser.dart';
import 'package:ebisu/ebisu.dart';
import 'package:petitparser/debug.dart';

// end <additional imports>

part 'src/test_parser/parse_enum.dart';
part 'src/test_parser/parse_import.dart';
part 'src/test_parser/parse_interface.dart';
part 'src/test_parser/parse_method.dart';
part 'src/test_parser/parse_struct.dart';
part 'src/test_parser/parse_types.dart';
part 'src/test_parser/parse_union.dart';

final _logger = new Logger('test_parser');

// custom <library test_parser>
// end <library test_parser>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  Logger.root.level = Level.WARNING;
  group('parse basic schema', () {
    final parser = new CapnpParser();

    final snippets = {
      'void': '''
struct F { x @1 :Void; }
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
      'using = name': 'using T = Foo',
      'using = qualifiedName': 'using T = Foo.Bar',
      'interface with method': '''
interface IF {
  nestedMethod @1 (arg1Name :arg1Type, arg2Name :arg2Type) -> (result :List(Int32));
  struct nestedStruct { }
  enum nestedEnum { red @0; }
  interface nestedInterface { }
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

  parseImportTests();
  parseTypeTests();
  parseEnumTests();
  parseUnionTests();
  parseStructTests();
  parseMethodTests();
  parseInterfaceTests();

// end <main>
}
