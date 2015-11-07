part of ebisu_capnp.test_parser;

// custom <part parse_struct>

final _validStructs = {
  'struct empty': 'struct S {}',
  'struct empty with comment': 'struct S { #Comment \n }',
  'struct with member': 'struct foo { abcde @1 :int; }',
  'struct with enum': '''
struct Foo { enum Goo { a @1; b @1; } }
''',
  'struct with union': '''
struct Foo { union X { abc @1 :int; } }
''',
  'struct with nested struct': '''
struct Foo { struct Goo { a @1 :int; } }
''',
};

parseStructTests() {
  final parser = new CapnpParser();
  _validStructs.forEach((String label, String capnp) {
    test(label, () => expect(parser.accept(capnp), true));
  });
}

// end <part parse_struct>
