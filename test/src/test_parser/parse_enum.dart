part of ebisu_capnp.test_parser;

// custom <part parse_enum>

final _validEnums = {
  'empty enum': 'enum foo {}',
  'empty enum with comment': 'enum foo { # comment\n }',
  'enum with multiple fields': '''
enum Operator {
    add @0;          ##
    subtract @1;   #
    multiply @2;  #
    divide @3;     ######
}''',
};

parseEnumTests() {
  final parser = new CapnpParser();
  _validEnums.forEach((String label, String capnp) {
    test(label, () => expect(parser.accept(capnp), true));
  });
}

// end <part parse_enum>