part of ebisu_capnp.capnp_schema;

class MethodParm {
  /// The name of the method parameter
  String name;

  /// The type of the method parameter
  String type;

  // custom <class MethodParm>

  MethodParm(this.name, this.type);

  toString() => '($name, $type)';

  // end <class MethodParm>

}

class MethodReturn {
  /// The name of the return
  String name;

  /// The type of the return
  String type;

  // custom <class MethodReturn>

  MethodReturn(this.name, this.type);

  toString() => '($name, $type)';

  // end <class MethodReturn>

}

class MethodDecl extends CapnpEntity with Numbered {
  /// The method parameters
  List<MethodParm> methodParms = [];
  MethodReturn methodReturn;

  // custom <class MethodDecl>

  MethodDecl(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  toString() =>
      'MethodDecl($id:@$number) ${methodParms.join(",")} -> $methodReturn';

  // end <class MethodDecl>

}

class Interface extends CapnpEntity {
  List<Interface> extend = [];
  List<MethodDecl> methodDecls = [];
  List<Interface> interfaces = [];
  List<Struct> structs = [];

  // custom <class Interface>

  Interface(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  toString() => '''
Interface($id)
  structs: [${structs.map((s) => s.id)}]
  methodDecls: [${methodDecls.map((md) => md.id)}]
  interfaces: [${interfaces.map((i) => i.id)}]
''';
  // end <class Interface>

}

// custom <part interface>
// end <part interface>
