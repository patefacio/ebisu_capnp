part of ebisu_capnp.capnp_schema;

class MethodDecl {
  // custom <class MethodDecl>
  // end <class MethodDecl>

}

class Method extends CapnpEntity with Numbered {
  MethodDecl methodDecl;

  // custom <class Method>

  Method(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  // end <class Method>

}

class Interface extends CapnpEntity {
  List<Interface> extend = [];
  List<Method> methods = [];

  // custom <class Interface>

  Interface(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  // end <class Interface>

}

// custom <part interface>
// end <part interface>
