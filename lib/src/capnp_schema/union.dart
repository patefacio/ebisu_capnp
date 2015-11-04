part of ebisu_capnp.capnp_schema;

class Union {
  /// Name of union or null if anonymous
  String name;
  List<Field> get fields => _fields;

  // custom <class Union>
  // end <class Union>

  List<Field> _fields = [];
}

// custom <part union>
// end <part union>
