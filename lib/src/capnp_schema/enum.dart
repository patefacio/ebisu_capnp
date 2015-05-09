part of ebisu_capnp.capnp_schema;

class EnumValue extends CapnpEntity with Numbered {

  // custom <class EnumValue>

  EnumValue(id, [number_ = 0]) : super(id) {
    number = number_;
  }

  get definition => brCompact(['$name @$number;', indentBlock(docComment),]);

  get name => CapnpEntity.namer.nameEnumValue(id);

  // end <class EnumValue>

}

class Enum extends CapnpEntity implements Definable, Referable {
  List<EnumValue> get values => _values;

  // custom <class Enum>

  Enum(id) : super(id);

  get definition => brCompact([
    _opener,
    indentBlock(docComment),
    indentBlock(br(values.map((v) => v.definition), '\n', true)),
    _closer,
  ]);

  get name => CapnpEntity.namer.nameEnum(id);

  set values(entries) => _values = enumerate(entries)
      .map((IndexedValue iv) => _makeEnumValue(iv.index, iv.value))
      .toList();

  get _opener => 'enum $name {';
  get _closer => '}';

  _makeEnumValue(index, entry) => (entry is String || entry is Id)
      ? new EnumValue(entry, index)
      : (entry is EnumValue)
          ? entry
          : throw 'Enum.values must have entries of type [String, Id, or EnumValue]';

  // end <class Enum>

  List<EnumValue> _values = [];
}

// custom <part enum>

EnumValue enumValue(id, number) => new EnumValue(id, number);
Enum enum_(id) => new Enum(id);

// end <part enum>
