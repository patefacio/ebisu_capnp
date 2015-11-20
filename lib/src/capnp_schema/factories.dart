part of ebisu_capnp.capnp_schema;

// custom <part factories>

final _namer = new DefaultNamer();

EnumValue enumValue(String id, number) =>
    new EnumValue(_namer.nameEnumValue(id), number);

Enum enum_(String id) => new Enum(_namer.nameEnum(id));

Constant const_(String id, type, value) =>
    new Constant(_namer.nameConst(id), type, value);

// end <part factories>
