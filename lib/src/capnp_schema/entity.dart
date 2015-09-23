part of ebisu_capnp.capnp_schema;

abstract class CapnpEntity extends Entity {
  /// The [Id] for the entity
  String get id => _id;
  static Namer namer = new DefaultNamer();

  // custom <class CapnpEntity>

  CapnpEntity(String id) : _id = id;

  get docComment {
    final contents = chomp(br([brief, descr]), true);
    if (contents.isNotEmpty) {
      return scriptComment(contents, '  ');
    }
    return null;
  }

  // end <class CapnpEntity>

  final String _id;
}

// custom <part entity>
// end <part entity>
