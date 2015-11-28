part of ebisu_capnp.test_parser;

// custom <part parse_interface>

final _validInterfaces = {
  'interface empty': 'interface Foo {}',
  'interface simple nested': 'interface Foo { interface Goo { }}',
  'interface with enum': 'interface Foo { enum Goo { }}',
  'interface with lots of stuff': '''
interface IF {
  nestedMethod @1 (arg1Name :Int32, arg2Name :Int64) -> (result :List(Int32));
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

  final interfaceSimpleNested = 'interface simple nested';
  test(interfaceSimpleNested, () {
    final schema = _validInterfaces[interfaceSimpleNested];
    final p = parser.parse(schema).value;
    expect(p.interfaces.first is Interface, true);
  });

  final lotsOfStuff = 'interface with lots of stuff';
  test(lotsOfStuff, () {
    final schema = _validInterfaces[lotsOfStuff];
    final p = parser.parse(schema).value;
    expect(p.interfaces.first is Interface, true);
  });
}

// end <part parse_interface>
