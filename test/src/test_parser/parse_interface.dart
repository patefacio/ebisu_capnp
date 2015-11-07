part of ebisu_capnp.test_parser;

// custom <part parse_interface>

final _validInterfaces = {
  'empty interface': 'interface Foo {}',
  'simple nested interface': 'interface Foo { interface Goo { }}',
  'interface with enum': 'interface Foo { enum Goo { }}',
};

parseInterfaceTests() {
  final parser = new CapnpParser();
  _validInterfaces.forEach((String label, String capnp) {
    test(label, () => expect(parser.accept(capnp), true));
  });
}

// end <part parse_interface>
