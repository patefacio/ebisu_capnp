part of ebisu_capnp.capnp_schema;

class Constant extends CapnpEntity implements Definable, Referable {
  Typed get type => _type;
  String get value => _value;

  // custom <class Constant>

  Constant(id, this._type, this._value) : super(id);

  get reference => throw 'TBD';

  get constStatement =>
      brCompact(['const $name $type = $value;', indentBlock(this.docComment)]);

  get definition => constStatement;

  // end <class Constant>

  Typed _type;
  String _value;
}

// custom <part constant>

Constant const_(id, type, value) => new Constant(id, type, value);

// end <part constant>
