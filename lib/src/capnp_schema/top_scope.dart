part of ebisu_capnp.capnp_schema;

class TopScope {
  List<Enum> enums = [];
  List<Interface> interfaces = [];
  List<Struct> structs = [];
  List<UsingStatement> usingStatements = [];

  // custom <class TopScope>

  get definition => br([
    enums.map((e) => e.definition),
    interfaces.map((i) => i.definition),
    structs.map((s) => s.definition)
  ]);

  toString() => definition;


  // end <class TopScope>

}

// custom <part top_scope>
// end <part top_scope>
