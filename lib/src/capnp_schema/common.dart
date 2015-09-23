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

  String nameEnum(String id);
  String nameEnumValue(String id);
  String nameStruct(String id);
  String nameMember(String id);
  String nameAliasUsing(String id);
  String nameConst(String id);

  // end <class Namer>

}

class DefaultNamer extends Namer {
  // custom <class DefaultNamer>

  String nameEnum(String id) => idFromString(id).capCamel;
  String nameEnumValue(String id) => '${idFromString(id).capSnake}_e';
  String nameStruct(String id) => idFromString(id).capCamel;
  String nameMember(String id) => idFromString(id).camel;
  String nameAliasUsing(String id) => '${idFromString(id).capSnake}_t';
  String nameConst(String id) => '${idFromString(id).snake}';

  // end <class DefaultNamer>

}

class Numbered {
  int number;

  // custom <class Numbered>
  // end <class Numbered>

}

// custom <part common>
// end <part common>
