part of ebisu_capnp.test_parser;

// custom <part parse_struct>

final _validStructs = {
  'empty struct': 'struct S {}',
  'empty struct with comment': 'struct S { #Comment \n }',
  'struct with member': 'struct foo { abcde @1 :int; }',
};

parseStructTests() {
  final parser = new CapnpParser();
  _logger.warning('TODO: Add tests for struct statement');
  _validStructs.forEach((String label, String capnp) {
    test(label, () => expect(parser.accept(capnp), true));
  });
}

// end <part parse_struct>
