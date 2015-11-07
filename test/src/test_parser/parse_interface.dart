part of ebisu_capnp.test_parser;

// custom <part parse_interface>

final _validInterfaces = {
  'interface empty': 'interface Foo {}',
  'interface simple nested': 'interface Foo { interface Goo { }}',
  'interface with enum': 'interface Foo { enum Goo { }}',
  'interface with lots of stuff': '''
interface IF {
  nestedMethod @1 (arg1Name :arg1Type, arg2Name :arg2Type) -> (result :List(Int32));
  struct nestedStruct { }
  enum nestedEnum { red @0; }
  interface nestedInterface { }
}
'''
};

parseInterfaceTests() {
  final parser = new CapnpParser();
  _validInterfaces.forEach((String label, String capnp) {
    test(label, () => expect(parser.accept(capnp), true));
  });
}

// end <part parse_interface>
