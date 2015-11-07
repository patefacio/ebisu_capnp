part of ebisu_capnp.test_parser;

// custom <part parse_method>

final _validMethods = {
  'method no args no return': 'foo @1 () -> ();',
  'method one arg no return': 'foo @1 (arg1 :arg1) -> ();',
  'method two args and return': '''
foo @1 (x :goo, y :moob) -> (goo :Int32) ;
''',
};

parseMethodTests() {
  final parser = new CapnpParser();
  _validMethods.forEach((String label, String capnp) {
    test(label, () => expect(parser.accept(capnp), true));
  });
}

// end <part parse_method>
