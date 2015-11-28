part of ebisu_capnp.test_parser;

// custom <part parse_union>

final _validUnions = {
  'union': '''
union X { abc @1 : int; }
''',
  'unnamed union': '''
union { abc @1 : int; }
''',
};

parseUnionTests() {
  final parser = new CapnpParser();
  _validUnions.forEach((String label, String capnp) {
    final s = '''
struct S {
  $capnp
}
''';
    test(label, () => expect(parser.accept(s), true));
  });
}

// end <part parse_union>
