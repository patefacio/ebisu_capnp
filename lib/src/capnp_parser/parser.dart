part of ebisu_capnp.capnp_parser;

class CapnpParser extends GrammarParser {
  // custom <class CapnpParser>

  CapnpParser() : super(const CapnpParserDefinition());

  // end <class CapnpParser>

}

class CapnpParserDefinition extends CapnpGrammarDefinition {
  // custom <class CapnpParserDefinition>

  const CapnpParserDefinition();

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
        _logger.info('Entries -> $entries');
        //assert(entries.every((e) => e is Member));
        final struct = new Struct(structName); //..members.addAll(entries);
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

  methodReturn() => super.methodReturn().map((var each) {
        return each[1];
      });

  methodParms() => super.methodParms().map((var each) {
    final methodParms = each[1];
    if(methodParms != null) {
      _logger.info('All parms $methodParms');
      for(var parm in methodParms) {
        _logger.info('bam $parm');
        final name = parm[0];
        final type = parm[1];
        _logger.info('Got parm ($name :$type)');
      }
    }
    return each[1];
  });

  method() => super.method().map((var each) {
        final methodName = each[0];
        final number = each[1];
        final methodParms = each[2];
        final methodReturn = each[4];
        _logger.info(
            'Method #$number hit Method($methodName($methodParms)) methodReturn($methodReturn)');
        return "Method($methodName)";
      });

  interfaceDefinition() => super.interfaceDefinition().map((var each) {
        final interfaceName = each[1];
        final interfaceMembers = each[3];
        for (var im in interfaceMembers) {
          _logger.info('\n\tfound im: ${im.runtimeType}');
        }

        _logger.info(
            'Interface <$interfaceName> ${interfaceMembers.runtimeType}(${interfaceMembers.length}) ${super.interfaceDefinition().flatten().map((e) => e.toString())})');
        return each;
      });

  interfaceMember() => super.interfaceMember().map((var each) => each);

  //////////////////////////////////////////////////////////////////////
  // Literal Related
  //////////////////////////////////////////////////////////////////////

  literalList() => super.literalList().map((var each) {
        final sourceList = each[1];
        if (sourceList != null && sourceList.length > 1) {
          final result = [sourceList[0]];
          result.addAll(sourceList[1]);
          _logger.info(
              'Returning ${result.runtimeType}(${result.length}) $result');
          return result;
        }
        return [];
      });

  literal() {
    return super.literal().map((var each) {
      _logger.info('Got *literal* ${each.runtimeType} -> $each');
      return each;
    });
  }

  listOfType() => super.listOfType().map((var each) {
        _logger.info('Got *listOfType* $each');
        return each;
      });

  literalElement() => super.literalElement().map((var each) {
        _logger.info('Got *literalElement* ${each.runtimeType} $each');
        return each;
      });

  literalNext() => super.literalNext().map((var each) {
        _logger.info('Got *literalNext* $each returning ${each[1]}');
        return each[1];
      });

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
