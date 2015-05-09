part of ebisu_capnp.capnp_schema;

class CapnpEntity extends Entity {

  /// The [Id] for the entity
  ///
  Id get id => _id;
  static Namer namer = new DefaultNamer();

  // custom <class CapnpEntity>

  CapnpEntity(id) : _id = makeId(id);

  get docComment {
    final contents = chomp(br([brief, descr]), true);
    if (contents.isNotEmpty) {
      return scriptComment(contents, '  ');
    }
    return null;
  }

  // end <class CapnpEntity>

  final Id _id;
}

// custom <part entity>
// end <part entity>
