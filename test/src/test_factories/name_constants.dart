part of ebisu_capnp.test_factories;

// custom <part name_constants>

final _constNameConversions = {
  const_('color', int32T, '32'): 'const Color Int32 = 32;',
};

testNamingConsts() {
  _constNameConversions.forEach((dynamic entry, String value) {
    test('${entry.runtimeType}-${entry.name}', () {
      _logger.info(entry.definition);
      expect(darkSame(entry.definition, value), true);
    });
  });
}

// end <part name_constants>
