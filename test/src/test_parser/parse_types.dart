part of ebisu_capnp.test_parser;

// custom <part parse_types>

final _validTypes = {
  'type - void' : ':Void',
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

// end <part parse_types>
