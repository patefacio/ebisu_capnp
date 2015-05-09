part of ebisu_capnp.capnp_schema;

class Member extends CapnpEntity with Numbered {

  /// Represents the name
  ///
  String id;
  String type;

  // custom <class Member>
  // end <class Member>

}


class Struct extends CapnpEntity {

  List<Member> members = [];
  List<Struct> structs = [];

  // custom <class Struct>
  // end <class Struct>

}

// custom <part struct>
// end <part struct>

