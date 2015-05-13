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

  /// Return the definition of the struct in IDL format
  get definition {
    final unionsVisited = new Set();
    final result = '''
struct $name {
${indentBlock(brCompact(_members.map((m) => _pullMember(m, unionsVisited))))}
}
''';
    return result;
  }

  /// Pull the member definition from the struct.
  ///
  /// If the member is in a union, pull in the entire union and mark that union
  /// as visited.
  String _pullMember(Member m, Set unionsVisited) {
    if (m.union != null) {
      if (!unionsVisited.contains(m.union)) {
        unionsVisited.add(m.union);
        return _pullUnion(m.union);
      }
      return null;
    }
    return m.definition;
  }

  /// Pull the members of a given union out as a *union*
  String _pullUnion(String union) => brCompact([
    br(['union', union == '' ? null : union, '{'], ' '),
    indentBlock(brCompact(
        _members.where((m) => m.union == union).map((m) => m.definition))),
    '}'
  ]);

  /// Set the members
  ///
  /// Supports elements of type [Member] and [String]
  /// If [String] is provided as a member the format is:
  ///
  ///  - 'NAME NUMBER' e.g. 'Foo 1' or 'Foo @1'
  ///  - 'NAME NUMBER TYPE' e.g. 'Foo 1 :Text'
  set members(members_) => _members =
      enumerate(members_).map((m) => _makeMember(m.value, m.index)).toList();

  /// Group the [fieldIds] together as a union named [unionName]
  ///
  /// No name provided indicates an anonymous union
  unionize(Iterable<dynamic> fieldIds, [String unionName = '']) => fieldIds
      .map((id) => makeId(id))
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
