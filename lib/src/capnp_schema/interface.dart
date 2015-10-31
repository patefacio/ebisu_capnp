part of ebisu_capnp.capnp_schema;

class MethodParm {
  /// The type of the method parameter
  String type;

  /// The name of the method parameter
  String name;

  // custom <class MethodParm>
  // end <class MethodParm>

}

class MethodDecl extends CapnpEntity with Numbered {
  /// The method parameters
  List<MethodParm> methodParms = [];

  // custom <class MethodDecl>

  MethodDecl(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  toString() => 'MethodDecl($id:@$number) ${methodParms.join(",")}';

  // end <class MethodDecl>

}

class Interface extends CapnpEntity {
  List<Interface> extend = [];
  List<Method> methods = [];
  List<Interface> get interfaces => _interfaces;
  List<Struct> structs = [];

  // custom <class Interface>

  Interface(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  // end <class Interface>

  List<Interface> _interfaces = [];
}

// custom <part interface>
// end <part interface>
