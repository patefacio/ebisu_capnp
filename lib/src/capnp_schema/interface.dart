part of ebisu_capnp.capnp_schema;

class MethodDecl {

  // custom <class MethodDecl>
  // end <class MethodDecl>

}


class Method extends CapnpEntity with Numbered {

  MethodDecl methodDecl;

  // custom <class Method>
  // end <class Method>

}


class Interface extends CapnpEntity {

  List<Interface> extend = [];
  List<Method> methods = [];

  // custom <class Interface>
  // end <class Interface>

}

// custom <part interface>
// end <part interface>

