part of ebisu_capnp.capnp_schema;

abstract class Definable {
  // custom <class Definable>

  String get definition;

  // end <class Definable>

}

abstract class Referable {
  // custom <class Referable>

  String get reference;

  // end <class Referable>

}

class Reference implements Typed {
  const Reference(this._type);

  String get type => _type;

  // custom <class Reference>
  // end <class Reference>

  final String _type;
}

abstract class Namer {
  // custom <class Namer>

  String nameEnum(Id id);
  String nameEnumValue(Id id);
  String nameStruct(Id id);
  String nameMember(Id id);
  String nameAliasUsing(Id id);
  String nameConst(Id id);

  // end <class Namer>

}

class DefaultNamer extends Namer {
  // custom <class DefaultNamer>

  String nameEnum(Id id) => id.capCamel;
  String nameEnumValue(Id id) => '${id.capSnake}_e';
  String nameStruct(Id id) => id.capCamel;
  String nameMember(Id id) => id.camel;
  String nameAliasUsing(Id id) => '${id.capSnake}_t';
  String nameConst(Id id) => '${id.snake}';

  // end <class DefaultNamer>

}

class Numbered {
  int number;

  // custom <class Numbered>
  // end <class Numbered>

}

// custom <part common>
// end <part common>
