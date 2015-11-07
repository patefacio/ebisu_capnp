part of ebisu_capnp.test_parser;

// custom <part parse_literal>

final _validLiterals = {
  'literal int': ':Int32 = 5',
  'literal int': ':Int32 = -5',
  'literal string': ':string = "abra cadabra"',
  'literal list strings': ':List(string) = [ "abra", "b", "z", "goo" ]',
  'literal list strings empty': ':List(string) = [ #empty \n ]',
  'literal list ints': ':List(Int32) = [ 1, 2222222222, 3, -2 ]',
  'literal list ints': ':List(Bool) = [ true, false ]',
  'literal list floats':
      ':Float = [ 1.0, -3.14, 2., 1.222222, 2., 0.00000001 ]\n',
};

parseLiteralTests() {
  final parser = new CapnpParser();
  _validLiterals.forEach((String label, String capnp) {
    final struct = '''
struct S {
  member @1 $capnp;
}
''';
    _logger.info('Parsing literal $capnp via $struct');
    test(label, () => expect(parser.accept(struct), true));
  });
}

// end <part parse_literal>
