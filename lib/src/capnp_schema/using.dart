part of ebisu_capnp.capnp_schema;

abstract class UsingStatement {
  // custom <class UsingStatement>
  // end <class UsingStatement>

}

class Using implements Definable, UsingStatement {
  String get reference => _reference;

  // custom <class Using>

  Using(this._reference);

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);
  get usingStatement => 'using $reference;';
  get definition => usingStatement;

  // end <class Using>

  String _reference;
}

class AliasUsing extends CapnpEntity implements UsingStatement {
  Using get using => _using;

  // custom <class AliasUsing>

  AliasUsing(aliasId, reference)
      : super(aliasId),
        _using = new Using(reference);

  Iterable<Entity> get children => new Iterable<Entity>.generate(0);
  get reference => using.reference;
  get name => CapnpEntity.namer.nameAliasUsing(id);
  get usingStatement =>
      brCompact(['using $name = $reference;', indentBlock(this.docComment)]);
  get definition => usingStatement;

  // end <class AliasUsing>

  Using _using;
}

// custom <part using>
// end <part using>
