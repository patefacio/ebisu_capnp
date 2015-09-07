library ebisu_capnp.test_parser;

import '../lib/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'package:ebisu_capnp/capnp_parser.dart';

// end <additional imports>

final _logger = new Logger('test_parser');

// custom <library test_parser>
// end <library test_parser>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  test('parse basic schema', () {
    final parser = new CapnpParser();

    final snippets = {
      'empty' : '',

      'struct': '''
struct foo {

  abce @1 :int

}
''',

      'enum': '''
enum foo { # bam
# bam
}
''',
      'method': '''
foo @1 -> x
'''
    };

    snippets.forEach((tag, text) {
      print('$tag -> ${parser.accept(text)}');
    });

  });

// end <main>
}
