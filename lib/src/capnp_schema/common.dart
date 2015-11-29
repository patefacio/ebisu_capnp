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
  String nameConst(String id) => '${idFromString(id).capSnake}';

  // end <class DefaultNamer>

}

class Numbered {
  int number;

  // custom <class Numbered>
  // end <class Numbered>

}

class UniqueId {
  const UniqueId(this.id);

  final int id;

  // custom <class UniqueId>

  String get asHex => '0x${id.toRadixString(16)}';

  toString() => asHex;

  // end <class UniqueId>

}

// custom <part common>

/// Given [parentId] which maps to outer scope or file if top level and [name],
/// returns unique id for *named* item.
UniqueId generateChildId(UniqueId parentId, String name) {
  final parentIdBytes = new List(8);
  for (int i = 0; i < 8; i++) {
    parentIdBytes[i] = (parentId.id >> (i * 8)) & 0xff;
  }

  final bytes = (new MD5()..add(parentIdBytes)..add(name.codeUnits)).close();

  new UniqueId(bytes.sublist(0, 8).fold(0, (prev, elm) => ((prev << 8) | elm)) |
      (1 << 63));
}

// end <part common>
