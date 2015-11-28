part of ebisu_capnp.capnp_schema;

class TopScope {
  List<Enum> get enums => _enums;
  List<Interface> get interfaces => _interfaces;
  List<Struct> get structs => _structs;
  List<UsingStatement> get usingStatements => _usingStatements;

  // custom <class TopScope>
  // end <class TopScope>

  List<Enum> _enums = [];
  List<Interface> _interfaces = [];
  List<Struct> _structs = [];
  List<UsingStatement> _usingStatements = [];
}

// custom <part top_scope>
// end <part top_scope>
