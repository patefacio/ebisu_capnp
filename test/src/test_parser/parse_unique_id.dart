part of ebisu_capnp.test_parser;

// custom <part parse_unique_id>

parseUniqueIdTests() {
  final parser = new CapnpParser();
  final uuid = 17214642667825373909;

  final result = parser.parse('@$uuid; struct S {}');

  test('unique id parses', () {
    expect(result.isSuccess, true);
    final TopScope topScope = result.value;
    expect(topScope.uniqueId.id, uuid);
  });
}

// end <part parse_unique_id>
