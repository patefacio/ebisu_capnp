part of ebisu_capnp.capnp_parser;

class CapnpParser extends GrammarParser {
  // custom <class CapnpParser>

  CapnpParser() : super(const CapnpParserDefinition());

  // end <class CapnpParser>

}

class CapnpParserDefinition extends CapnpGrammarDefinition {
  // custom <class CapnpParserDefinition>

  const CapnpParserDefinition();

  start() => super.start().map((var each) {
        final result = new TopScope()
          ..uniqueId = each.firstWhere((s) => s is UniqueId, orElse: () => null)
          ..structs = each.where((s) => s is Struct).toList()
          ..interfaces = each.where((i) => i is Interface).toList()
          ..enums = each.where((e) => e is Enum).toList();

        _logger.info(result.definition);
        return result;
      });

  identifier() => super.identifier().flatten().map((var each) {
        _logger.info('Got id ${each}');
        return each;
      });

  predefinedType() => super.predefinedType().flatten().map((each) {
        _logger.info('Got *predefinedType* $each');
        return each;
      });

  userDefinedType() => super.userDefinedType().flatten().map((var each) {
        _logger.info('Got UDT ${each}');
        return each;
      });

  numberAttribute() => super.numberAttribute().map((var each) {
        _logger.info('Got *numberAttribute* $each');
        return each;
      });

  enumDefinition() => super.enumDefinition().map((var each) {
        final enumName = each[1];
        final enumMemberDefinitions = each[3];
        final enumDefinition = new Enum(enumName)
          ..values = enumMemberDefinitions;
        _logger.info('Got *enumDefinition* ($enumName)\n$enumDefinition');
        return enumDefinition;
      });

  enumMember() => super.enumMember().map((var each) {
        _logger.info('Got *enumMember* $each');
        return new EnumValue(each[0].value, each[1]);
      });

  enumMemberDefinition() =>
      super.enumMemberDefinition().map((var each) => each);

  enumMemberIdentifier() => super.enumMemberIdentifier().map((var each) {
        _logger.info('Got *enumMemberIdentifier* $each');
        return each;
      });

  enumMemberNumberIdentifier() =>
      super.enumMemberNumberIdentifier().flatten().map((var each) {
        _logger.info('Got *enumMemberNumberIdentifier* $each');
        return each;
      });

  //////////////////////////////////////////////////////////////////////
  // Struct Related
  //////////////////////////////////////////////////////////////////////

  structDefinition() => super.structDefinition().map((var each) {
        final structName = each[1];
        final entries = each[3];
        final struct = new Struct(structName)
          ..fields.addAll(entries.where((e) => e is Field))
          ..interfaces.addAll(entries.where((e) => e is Interface))
          ..structs.addAll(entries.where((e) => e is Struct))
          ..enums.addAll(entries.where((e) => e is Enum));

        _logger.info('Struct Def($structName)\n$struct');
        return struct;
      });

  structField() => super.structField().map((var each) {
        final name = each[0];
        final numberAttribute = each[1];
        final typeSpecifier = each[2];
        final optionalLiteralAssignment = each[3];
        final schemaMember = new Field(name, numberAttribute);
        _logger.info(
            'Struct (name:$name, num:$numberAttribute, type:$typeSpecifier, '
            'literalAssign:$optionalLiteralAssignment');
        return schemaMember;
      });

  //////////////////////////////////////////////////////////////////////
  // Interface Related
  //////////////////////////////////////////////////////////////////////

  typedValue() => super.typedValue().map((var each) {
        _logger.info('TypedValue => ${[ each[0], each[1][1] ]}');
        return [each[0], each[1][1]];
      });

  typedValueList() => super.typedValueList().map((var each) {
        _logger.info('TypedValueList $each');
        return each;
      });

  methodReturn() => super.methodReturn().map(
      (var each) => each == null ? null : new MethodReturn(each[0], each[1]));

  methodParms() =>
      super.methodParms().map((List methodParms) => methodParms == null
          ? []
          : methodParms.map((tv) => new MethodParm(tv[0], tv[1])).toList());

  method() => super.method().map((var each) => new MethodDecl(each[0])
    ..number = each[1]
    ..methodParms = each[2]
    ..methodReturn = each[4]);

  interfaceDefinition() => super.interfaceDefinition().map((var each) {
        final interfaceName = each[1];
        final methodDecls = [];
        final interfaces = [];
        final structs = [];
        final enums = [];

        final interfaceMembers = each[3];
        for (var im in interfaceMembers) {
          if (im is Interface) interfaces.add(im);
          else if (im is Struct) structs.add(im);
          else if (im is Enum) enums.add(im);
          else if (im is MethodDecl) methodDecls.add(im);
          else _logger
              .warning('Not interfaceDefinition member ${im.runtimeType}');
        }

        final interfaceDefinition = new Interface(interfaceName)
          ..methodDecls = methodDecls
          ..interfaces = interfaces
          ..structs = structs
          ..enums = enums;

        _logger.info('ID -> $interfaceDefinition');
        return interfaceDefinition;
      });

  //////////////////////////////////////////////////////////////////////
  // Literal Related
  //////////////////////////////////////////////////////////////////////

  listOfType() => super.listOfType().map((var each) {
        _logger.info('Got *listOfType* $each');
        return each;
      });

  literalElement() => super.literalElement().map((var each) {
        _logger.info('Got *literalElement* ${each.runtimeType} $each');
        return each;
      });

  /*
  literalNext() => super.literalNext().map((var each) {
        _logger.info('Got *literalNext* $each returning ${each[1]}');
        return each[1];
      });
  */

  literalString() => super.literalString().map((var each) => each[1].join());

  literalEnum() => super.literalEnum().flatten().map((var each) {
        _logger.info('Got *literalEnum* $each');
        return each;
      });

  literalInt() => super.literalInt().flatten().map((var each) {
        _logger.info('Got *literalInt* $each');
        return int.parse(each);
      });

  literalFloat() => super.literalFloat().flatten().map((var each) {
        _logger.info('Got *literalFloat* $each');
        return double.parse(each);
      });

  // end <class CapnpParserDefinition>

}

// custom <part parser>
// end <part parser>
