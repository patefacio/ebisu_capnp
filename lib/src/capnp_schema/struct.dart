part of ebisu_capnp.capnp_schema;

class Member extends CapnpEntity with Numbered {
  String type;

  // custom <class Member>
  Member(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  // end <class Member>

}

class Struct extends CapnpEntity {
  List<Member> members = [];
  List<Struct> structs = [];

  // custom <class Struct>
  Struct(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);

  // end <class Struct>

}

// custom <part struct>
// end <part struct>
