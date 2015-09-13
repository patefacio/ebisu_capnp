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
      ref(structMember).star() &
      ref(token, '}');
  structEntry() => ref(structDefinition) | ref(structMember) | ref(enumMember);


  unionDefinition() => ref(UNION) &
      ref(identifier) &
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
      ref(typeSpecifier);

  numberAttribute() => ref(token, '@') & ref(digit).plus();

  topLevelEntry() => ref(structDefinition) |
      ref(interfaceDefinition) |
      ref(enumDefinition) |
      ref(method) |
      ref(usingStatement) |
      ref(unionDefinition) |
      ref(methodReturn);

  typeSpecifier() => ref(token, ':') & ref(identifier);
  typedValue() => ref(identifier) & ref(typeSpecifier);
  typedValueList() =>
      ref(typedValue) & (ref(token, ',') & ref(typedValue)).star();

  identifier() => letter() & word().star();

  qualified() =>
      ref(identifier) & (ref(token, '.') & ref(identifier)).optional();

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

  // end <class CapnpParserDefinition>

}

// custom <part parser>
// end <part parser>
