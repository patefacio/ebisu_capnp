part of ebisu_capnp.test_parser;

// custom <part parse_enum>

final _validEnums = {
  'empty enum': 'enum Foo {}',
  'empty enum with comment': 'enum Foo { # comment\n }',
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

    final s = 'struct S { $capnp }';
    test(label, () => expect(parser.accept(s), true));
  });

  test('catches invalid *enum* name', () {
    expect(() => parser.parse('enum shouldStartCapital {}'), throwsException);
  });

}

// end <part parse_enum>
