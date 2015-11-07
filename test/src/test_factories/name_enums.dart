part of ebisu_capnp.test_factories;

// custom <part name_enums>

final _enumNameConversions = {
  enum_('color'): 'enum Color {}',
  enum_('color_wheel'): 'enum ColorWheel {}',
  enum_('ColorWheel'): 'enum ColorWheel {}',
  enumValue('red', 1): 'Red_e @1;',
  enumValue('big_red', 1): 'Big_red_e @1;',
  enumValue('BigRed', 1): 'Big_red_e @1;',
};

testNamingEnums() {
  _enumNameConversions.forEach((dynamic entry, String value) {
    test('${entry.runtimeType}-${entry.name}', () {
      _logger.info(entry.definition);
      expect(darkSame(entry.definition, value), true);
    });
  });
}

// end <part name_enums>
