part of ebisu_capnp.capnp_schema;

class MethodParm {
  /// The name of the method parameter
  String name;

  /// The type of the method parameter
  String type;

  // custom <class MethodParm>

  MethodParm(this.name, this.type);

  get definition => '$name :$type';

  toString() => definition;

  // end <class MethodParm>

}

class MethodReturn {
  /// The name of the return
  String name;

  /// The type of the return
  String type;

  // custom <class MethodReturn>

  MethodReturn(this.name, this.type);

  toString() => '($name :$type)';

  // end <class MethodReturn>

}

class MethodDecl extends CapnpEntity with Numbered {
  /// The method parameters
  List<MethodParm> methodParms = [];
  MethodReturn methodReturn;

  // custom <class MethodDecl>

  MethodDecl(id) : super(id);

  get _expanded => [
    '$id $number (',
    indentBlock(methodParms.map((mp) => mp.definition).join(',\n')),
    ') -> $methodReturn',
  ];

  get _inlined => [
    '$id $number (${methodParms.map((mp) => mp.definition).join(", ")}) -> $methodReturn;'
  ];

  get definition => brCompact([
    methodParms.length > 2? _expanded : _inlined
  ]);

  toString() =>
      'MethodDecl($id:@$number) ${methodParms.join(",")} -> $methodReturn;';

  // end <class MethodDecl>

}

class Interface extends CapnpEntity {
  List<Interface> extend = [];
  List<MethodDecl> methodDecls = [];
  List<Interface> interfaces = [];
  List<Struct> structs = [];
  List<Enum> enums = [];

  // custom <class Interface>

  Interface(id) : super(id);

  get definition => brCompact([
    'interface $name {',
    indentBlock(brCompact(enums.map((e) => e.definition))),
    indentBlock(brCompact(methodDecls.map((m) => m.definition))),
    indentBlock(brCompact(interfaces.map((i) => i.definition))),
    indentBlock(brCompact(structs.map((s) => s.definition))),
    '}'
  ]);

  toString() => '''
Interface($id)
  structs: [${structs.map(_itemId)}]
  methodDecls: [${methodDecls.map(_itemId)}]
  interfaces: [${interfaces.map(_itemId)}]
  enums: [${enums.map(_itemId)}]
''';
  // end <class Interface>

}

// custom <part interface>

String _itemId(item) => item.id;

// end <part interface>
