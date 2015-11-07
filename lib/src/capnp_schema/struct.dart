part of ebisu_capnp.capnp_schema;

class Field extends CapnpEntity with Numbered implements Definable, Referable {
  Typed type;

  /// If present, the union it belongs to.
  ///
  /// For an anonymous union use empty string ""
  String union;
  dynamic get defaultValue => _defaultValue;

  // custom <class Field>
  Field(id, int number_, [this.type = int32T]) : super(id) {
    number = number_;
  }

  get definition =>
      combine([name, '@$number', type.type, _defaultAssign], ' ') + ';';

  set defaultValue(defaultValue_) {
    if (type == null) {
      type = defaultValue_ is String
          ? 'textT'
          : defaultValue_ is int
              ? 'int32T'
              : defaultValue_ is double
                  ? 'float64T'
                  : defaultValue_ is List ? 'listT' : type;
    }
    _defaultValue = type is String ? smartQuote(defaultValue_) : defaultValue_;
  }

  get _defaultAssign => _defaultValue != null ? '= $_defaultValue' : null;

  String toString() => definition;
  // end <class Field>

  dynamic _defaultValue;
}

class Struct extends CapnpEntity
    implements Definable, Referable, UserDefinedType {
  List<Field> get fields => _fields;
  List<Interface> get interfaces => _interfaces;
  List<Struct> structs = [];

  // custom <class Struct>
  Struct(id) : super(id);

  /// Return the definition of the struct in IDL format
  get definition {
    final unionsVisited = new Set();
    final result = '''
struct $name {
${indentBlock(brCompact(interfaces.map((i) => i.definition)))}
${indentBlock(brCompact(structs.map((s) => s.definition)))}
${indentBlock(brCompact(_fields.map((m) => _pullField(m, unionsVisited))))}
}
''';
    return result;
  }

  String toString() => definition;

  /// Pull the field definition from the struct.
  ///
  /// If the field is in a union, pull in the entire union and mark that union
  /// as visited.
  String _pullField(Field m, Set unionsVisited) {
    if (m.union != null) {
      if (!unionsVisited.contains(m.union)) {
        unionsVisited.add(m.union);
        return _pullUnion(m.union);
      }
      return null;
    }
    return m.definition;
  }

  /// Pull the fields of a given union out as a *union*
  String _pullUnion(String union) => brCompact([
        br(['union', union == '' ? null : union, '{'], ' '),
        indentBlock(brCompact(
            _fields.where((m) => m.union == union).map((m) => m.definition))),
        '}'
      ]);

  /// Set the fields
  ///
  /// Supports elements of type [Field] and [String]
  /// If [String] is provided as a field the format is:
  ///
  ///  - 'NAME NUMBER' e.g. 'Foo 1' or 'Foo @1'
  ///  - 'NAME NUMBER TYPE' e.g. 'Foo 1 :Text'
  set fields(fields_) => _fields =
      enumerate(fields_).map((m) => _makeField(m.value, m.index)).toList();

  /// Group the [fieldIds] together as a union named [unionName]
  ///
  /// No name provided indicates an anonymous union
  unionize(Iterable<dynamic> fieldIds, [String unionName = '']) => fieldIds
      .map((id) => id)
      .forEach((id) => fields.firstWhere((m) => id == m.id).union = unionName);

  final RegExp _whiteSpace = new RegExp(r'\s+');

  _getNumber(s) => int.parse(s.replaceAll('@', ''));

  _makeField(m, int index) {
    if (m is Field) {
      return m;
    } else if (m is String) {
      final parts = m.split(_whiteSpace);
      switch (parts.length) {
        case 2:
          return field(parts[0], _getNumber(parts[1]));
        case 3:
          return field(parts[0], _getNumber(parts[1]), new Reference(parts[2]));
        case 1:
        default:
          throw 'Field from string takes 2 or 3 terms';
      }
    } else {
      throw 'Field type unexpected';
    }
  }

  // end <class Struct>

  List<Field> _fields = [];
  List<Interface> _interfaces = [];
}

// custom <part struct>

Field field(id, int number, [type = int32T]) => new Field(id, number, type);
Struct struct(id) => new Struct(id);

// end <part struct>
