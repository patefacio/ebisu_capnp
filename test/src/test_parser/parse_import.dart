part of ebisu_capnp.test_parser;

// custom <part parse_import>

final _validImports = {};

parseImportTests() {
  final parser = new CapnpParser();
  _logger.warning('TODO: Add tests for import statement');
  _validImports.forEach((String label, String capnp) {
    test(label, () => expect(parser.accept(capnp), true));
  });
}

// end <part parse_import>
