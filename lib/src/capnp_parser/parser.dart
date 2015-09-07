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
      ref(token, identifier) &
      ref(token, '{') &
      ref(structMember).star() &
      ref(token, '}');

  enumDefinition() => ref(ENUM) &
      ref(token, identifier) &
      ref(token, '{') &
      ref(enumMember).star() &
      ref(token, '}');

  method() => ref(token, identifier) &
    ref(token, numberAttribute) &
    ref(token, string('->'));

  structMember() => ref(token, identifier) &
      ref(token, numberAttribute) &
      ref(token, typeSpecifier);

  numberAttribute() => char('@') & ref(digit).plus();

  enumMember() => ref(token, identifier);
  structEntry() => ref(structDefinition) | ref(structMember) | ref(enumMember);
  topLevelEntry() => ref(structDefinition) | ref(enumDefinition) | ref(method);
  typeSpecifier() => char(':') & ref(identifier);

  identifier() => letter() & word().star();

  STRUCT() => ref(token, 'struct');
  ENUM() => ref(token, 'enum');

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
