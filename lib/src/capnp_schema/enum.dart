part of ebisu_capnp.capnp_schema;

class EnumValue extends CapnpEntity with Numbered {

  // custom <class EnumValue>

  EnumValue(id) : super(id);

  get definition => '$name';
  get name => CapnpEntity.namer.nameEnumValue(id);

  // end <class EnumValue>

}

class Enum extends CapnpEntity implements Definable, Referable {
  List<EnumValue> get values => _values;

  // custom <class Enum>

  Enum(id) : super(id);

  get definition => brCompact([
    _opener,
    indentBlock(br(values.map((v) => v.definition), ',\n', true)),
    _closer,
  ]);

  get name => CapnpEntity.namer.nameEnum(id);

  set values(entries) =>
    _values = entries.map((e) => _makeEnumValue(e)).toList();

  get _opener => 'enum $name {';
  get _closer => '}';

  _makeEnumValue(entry) =>
    (entry is String || entry is Id)? new EnumValue(entry) :
    (entry is EnumValue)? entry :
    throw 'Enum.values must have entries of type [String, Id, or EnumValue]';

  // end <class Enum>

  List<EnumValue> _values = [];
}

// custom <part enum>

Enum enum_(id) => new Enum(id);

// end <part enum>
