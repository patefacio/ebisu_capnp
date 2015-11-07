part of ebisu_capnp.test_parser;

// custom <part parse_type>

final _validTypes = {
  'type - void': ':Void',
  'type - int': ':Int32',
  'type - list of int': ':List(Int32)',
  'type - list of list of int': ':List(List(Int32))',
};

parseTypeTests() {
  final parser = new CapnpParser();
  _validTypes.forEach((String label, String capnp) {
    final struct = '''
struct S {
  member @1 $capnp;
}
''';
    _logger.info('Parsing type $capnp via $struct');
    test(label, () => expect(parser.accept(struct), true));
  });
}

// end <part parse_type>
