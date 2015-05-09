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

abstract class Namer {

  // custom <class Namer>

  String nameEnum(Id id);
  String nameEnumValue(Id id);
  String nameStruct(Id id);
  String nameAliasUsing(Id id);

  // end <class Namer>

}

class DefaultNamer extends Namer {

  // custom <class DefaultNamer>

  String nameEnum(Id id) => id.capCamel;
  String nameEnumValue(Id id) => '${id.capCamel}_e';
  String nameStruct(Id id) => id.capCamel;
  String nameAliasUsing(Id id) => '${id.capCamel}_t';

  // end <class DefaultNamer>

}

class Numbered {
  int number;

  // custom <class Numbered>
  // end <class Numbered>

}

// custom <part common>
// end <part common>
