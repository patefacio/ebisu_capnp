part of ebisu_capnp.capnp_parser;

class CapnpGrammar extends GrammarParser {
  // custom <class CapnpGrammar>

  CapnpGrammar() : super(const CapnpGrammarDefinition());

  // end <class CapnpGrammar>

}

class CapnpGrammarDefinition extends GrammarDefinition {
  // custom <class CapnpGrammarDefinition>

  const CapnpGrammarDefinition();

  Parser token(input) {
    if (input is String) {
      input = input.length == 1 ? char(input) : string(input);
    } else if (input is Function) {
      input = ref(input);
    }
    if (input is! Parser && input is TrimmingParser) {
      throw new StateError('Invalid token parser: $input');
    }
    return input.token().trim(ref(HIDDEN));
  }

  start() => ref(topLevelEntry).star().end();

  structDefinition() => ref(STRUCT) &
      ref(identifier) &
      ref(token, '{') &
      ref(structEntry).star() &
      ref(token, '}');
  structEntry() => ref(structDefinition) |
      ref(structMember) |
      ref(enumDefinition) |
      ref(unionDefinition);

  unionDefinition() => ref(UNION) &
      ref(identifier).optional() &
      ref(token, '{') &
      ref(unionEntry).star() &
      ref(token, '}');

  unionEntry() => ref(structMember);

  enumDefinition() => ref(ENUM) &
      ref(identifier) &
      ref(token, '{') &
      ref(enumMemberStatement).star() &
      ref(token, '}');

  enumMember() => ref(identifier) & ref(numberAttribute);
  enumMemberStatement() => ref(enumMember) & ref(token, ';');

  interfaceDefinition() => ref(INTERFACE) &
      ref(identifier) &
      ref(token, '{') &
      ref(interfaceMember).star() &
      ref(token, '}');

  interfaceMember() => (ref(method) |
      ref(structDefinition) |
      ref(interfaceDefinition) |
      ref(enumDefinition));

  usingStatement() =>
      ref(USING) & ref(identifier) & ref(token, '=') & ref(scopeName);

  scopeName() => ref(qualified);

  method() => ref(identifier) &
      ref(numberAttribute) &
      ref(methodParms) &
      ref(token, string('->')) &
      ref(methodReturn);

  methodParms() =>
      ref(token, '(') & ref(typedValueList).optional() & ref(token, ')');

  methodReturn() =>
      ref(token, '(') & ref(typedValue).optional() & ref(token, ')');

  structMember() => ref(identifier) &
      ref(numberAttribute) &
      ref(typeSpecifier) &
      (ref(token, '=') & ref(literal)).optional() &
      ref(token, ';');

  numberAttribute() => ref(token, '@') & ref(digit).plus();

  topLevelEntry() => ref(structDefinition) |
      ref(interfaceDefinition) |
      ref(enumDefinition) |
      ref(method) |
      ref(usingStatement) |
      ref(unionDefinition) |
      ref(literal) |
      ref(methodReturn);

  typeSpecifier() => ref(token, ':') & ref(typeIdentifier);

  typedValue() => ref(identifier) & ref(typeSpecifier);

  typeIdentifier() => ref(predefinedType) | ref(userDefinedType);

  predefinedType() => ref(VOID_TYPE) |
      ref(BOOLEAN_TYPE) |
      ref(INT8_TYPE) |
      ref(INT16_TYPE) |
      ref(INT32_TYPE) |
      ref(UINT8_TYPE) |
      ref(UINT16_TYPE) |
      ref(UINT32_TYPE) |
      ref(FLOAT32_TYPE) |
      ref(FLOAT64_TYPE) |
      ref(BLOB_TEXT_TYPE) |
      ref(BLOB_DATA_TYPE) |
      ref(listOfType);

  listOfType() =>
      ref(LIST_TYPE) & ref(token, '(') & ref(typeIdentifier) & ref(token, ')');

  userDefinedType() => ref(identifier);

  typedValueList() =>
      ref(typedValue) & (ref(token, ',') & ref(typedValue)).star();

  identifier() => letter() & word().star();

  qualified() =>
      ref(identifier) & (ref(token, '.') & ref(identifier)).optional();

  literal() => ref(literalElement) | ref(literalList);

  literalList() => ref(token, char('[')) &
      ref(literalElements).optional() &
      ref(token, char(']'));

  literalElements() =>
      ref(literalElement) & (ref(token, ',') & ref(literalElement)).star();

  literalString() =>
      ref(token, char('"')) & pattern('^"').star() & ref(token, char('"'));

  literalEnum() => string('true') | string('false');

  literalInt() => char('-').optional() & char('0').or(digit().plus());

  literalFloat() => char('-').optional() &
      char('0').or(digit().plus()) &
      char('.').seq(digit().plus()).optional() &
      pattern('eE')
          .seq(pattern('-+').optional())
          .seq(digit().plus())
          .optional();

  literalElement() => ref(literalString) |
      ref(literalEnum) |
      ref(literalFloat) |
      ref(literalInt);

  VOID_TYPE() => ref(token, 'Void');
  BOOLEAN_TYPE() => ref(token, 'Bool');

  INT8_TYPE() => ref(token, 'Int8');
  INT16_TYPE() => ref(token, 'Int16');
  INT32_TYPE() => ref(token, 'Int32');
  INT64_TYPE() => ref(token, 'Int64');

  UINT8_TYPE() => ref(token, 'UInt8');
  UINT16_TYPE() => ref(token, 'UInt16');
  UINT32_TYPE() => ref(token, 'UInt32');
  UINT64_TYPE() => ref(token, 'UInt64');

  FLOAT32_TYPE() => ref(token, 'Float32');
  FLOAT64_TYPE() => ref(token, 'Float64');
  BLOB_TEXT_TYPE() => ref(token, 'Text');
  BLOB_DATA_TYPE() => ref(token, 'Data');

  LIST_TYPE() => ref(token, 'List');

  STRUCT() => ref(token, 'struct');
  INTERFACE() => ref(token, 'interface');
  ENUM() => ref(token, 'enum');
  USING() => ref(token, 'using');
  UNION() => ref(token, 'union');

  // -----------------------------------------------------------------
  // Whitespace and comments.
  // -----------------------------------------------------------------
  NEWLINE() => pattern('\n\r');

  HIDDEN() => ref(HIDDEN_STUFF).plus();

  HIDDEN_STUFF() =>
      ref(WHITESPACE) | ref(SINGLE_LINE_COMMENT) | ref(MULTI_LINE_COMMENT);

  WHITESPACE() => whitespace();

  SINGLE_LINE_COMMENT() =>
      string('#') & ref(NEWLINE).neg().star() & ref(NEWLINE).optional();

  MULTI_LINE_COMMENT() => string('/*') &
      (ref(MULTI_LINE_COMMENT) | string('*/').neg()).star() &
      string('*/');

  // end <class CapnpGrammarDefinition>

}

class CapnpParser extends GrammarParser {
  // custom <class CapnpParser>

  CapnpParser() : super(const CapnpParserDefinition());

  // end <class CapnpParser>

}

class CapnpParserDefinition extends CapnpGrammarDefinition {
  // custom <class CapnpParserDefinition>

  const CapnpParserDefinition();

  identifier() => super.identifier().flatten().map((each) {
        _logger.info('Got id ${each}');
        return each;
      });

  predefinedType() => super.predefinedType().flatten().map((each) {
        _logger.info('Got *predefinedType* $each');
        return each;
      });

  userDefinedType() => super.userDefinedType().flatten().map((each) {
        _logger.info('Got UDT ${each}');
        return each;
      });

  listOfType() =>
      super.listOfType().map((each) => _logger.info('Got *listOfType* $each'));

  // end <class CapnpParserDefinition>

}

// custom <part parser>
// end <part parser>
