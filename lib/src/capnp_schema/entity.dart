part of ebisu_capnp.capnp_schema;

abstract class CapnpEntity {
  /// The [Id] for the entity
  String get id => _id;
  String docComment;

  // custom <class CapnpEntity>

  CapnpEntity(String id) : _id = id;

  get capnp;

  get name => id;

  // end <class CapnpEntity>

  final String _id;
}

// custom <part entity>
// end <part entity>
