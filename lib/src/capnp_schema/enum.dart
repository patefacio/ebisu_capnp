part of ebisu_capnp.capnp_schema;

class EnumValue extends CapnpEntity with Numbered {
  // custom <class EnumValue>

  EnumValue(id, number_) : super(id) {
    number = number_;
  }

  get definition =>
      brCompact(['$name @$number;', indentBlock(this.docComment),]);

  toString() => 'EV($id, $number)';

  // end <class EnumValue>

}

class Enum extends CapnpEntity implements Definable, Referable {
  List<EnumValue> get values => _values;

  // custom <class Enum>

  Enum(id) : super(id);

  get reference => throw 'TBD';

  get definition => brCompact([
        _opener,
        indentBlock(this.docComment),
        indentBlock(br(values.map((v) => v.definition), '\n', true)),
        _closer,
      ]);

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

  String toString() => definition;

  // end <class Enum>

  List<EnumValue> _values = [];
}

// custom <part enum>
// end <part enum>
