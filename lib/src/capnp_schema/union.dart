part of ebisu_capnp.capnp_schema;

class Union {

  /// Name of union or null if anonymous
  String name;
  List<Member> get members => _members;

  // custom <class Union>
  // end <class Union>

  List<Member> _members = [];
}

// custom <part union>
// end <part union>
