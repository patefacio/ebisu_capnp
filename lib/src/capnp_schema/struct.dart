part of ebisu_capnp.capnp_schema;

class Member extends CapnpEntity with Numbered implements Definable, Referable {
  Typed type;
  /// If present, the union it belongs to.
  ///
  /// For an anonymous union use empty string ""
  String union;

  // custom <class Member>
  Member(id, int number_, [this.type = int32T]) : super(id) {
    number = number_;
  }
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);
  get name => CapnpEntity.namer.nameMember(id);
  get definition => '$name @$number ${type.type};';

  // end <class Member>

}

class Struct extends CapnpEntity implements Definable, Referable {
  List<Member> get members => _members;
  List<Struct> structs = [];

  // custom <class Struct>
  Struct(id) : super(id);
  Iterable<Entity> get children => new Iterable<Entity>.generate(0);
  get name => CapnpEntity.namer.nameStruct(id);
  get definition => '''
struct $name {
${indentBlock(brCompact(members.map((m) => m.definition)))}
}
''';

  set members(members_) => _members =
      enumerate(members_).map((m) => _makeMember(m.value, m.index)).toList();

  unionize(Iterable<dynamic> fieldIds, [ String unionName = '']) =>
    fieldIds.map((id) => makeId(id))
    .forEach((id) => members.firstWhere((m) => id == m.id).union = unionName);

  final RegExp _whiteSpace = new RegExp(r'\s+');

  _getNumber(s) => int.parse(s.replaceAll('@', ''));

  _makeMember(m, int index) {
    if (m is Member) {
      return m;
    } else if (m is String) {
      final parts = m.split(_whiteSpace);
      switch (parts.length) {
        case 2:
          return member(parts[0], _getNumber(parts[1]));
        case 3:
          return member(
              parts[0], _getNumber(parts[1]), new Reference(parts[2]));
        case 1:
        default:
          throw 'Member from string takes 2 or 3 terms';
      }
    } else {
      throw 'Member type unexpected';
    }
  }

  // end <class Struct>

  List<Member> _members = [];
}

// custom <part struct>

Member member(id, int number, [type = int32T]) => new Member(id, number, type);
Struct struct(id) => new Struct(id);

// end <part struct>
