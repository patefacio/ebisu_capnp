part of ebisu_capnp.test_parser;

// custom <part parse_using>

final _validUsings = {
  'using = name': 'using T = Foo',
  'using = qualifiedName': 'using T = Foo.Bar',
};

parseUsingTests() {
  final parser = new CapnpParser();
  _validUsings.forEach((String label, String capnp) {
    test(label, () => expect(parser.accept(capnp), true));
  });
}

// end <part parse_using>
