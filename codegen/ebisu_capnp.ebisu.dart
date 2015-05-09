import "dart:io";
import "package:path/path.dart" as path;
import "package:ebisu/ebisu.dart";
import "package:ebisu/ebisu_dart_meta.dart";
import "package:logging/logging.dart";

String _topDir;

void main() {

  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
  String here = path.absolute(Platform.script.toFilePath());

  Logger.root.level = Level.OFF;

  final purpose = '''
A library focusing on capnp modeling and enhancement
''';

  _topDir = path.dirname(path.dirname(here));
  useDartFormatter = true;
  System ebisu = system('ebisu_capnp')
    ..rootPath = _topDir
    ..includesHop = true
    ..license = 'boost'
    ..pubSpec.homepage = 'https://github.com/patefacio/ebisu_capnp'
    ..doc = purpose
    ..testLibraries = [
      library('test_built_in')..imports = ['../lib/capnp_schema.dart'],
      library('test_enum')..imports = ['../lib/capnp_schema.dart'],
      library('test_entity')..imports = ['../lib/capnp_schema.dart'],
      library('test_using')..imports = ['../lib/capnp_schema.dart'],
      library('test_struct')..imports = ['../lib/capnp_schema.dart'],
      library('test_union')..imports = ['../lib/capnp_schema.dart'],
      library('test_group')..imports = ['../lib/capnp_schema.dart'],
      library('test_interface')..imports = ['../lib/capnp_schema.dart'],
      library('test_generic')..imports = ['../lib/capnp_schema.dart'],
      library('test_constant')..imports = ['../lib/capnp_schema.dart'],
      library('test_import')..imports = ['../lib/capnp_schema.dart'],
      library('test_annotation')..imports = ['../lib/capnp_schema.dart'],
      library('test_schema')..imports = ['../lib/capnp_schema.dart'],
    ]
    ..libraries = [

      library('capnp_generation'),

      library('capnp_schema')
      ..imports = [
        'package:id/id.dart',
        'package:ebisu/ebisu.dart',
        'package:quiver/iterables.dart',
      ]
      ..parts = [

        part('common')
        ..classes = [

          class_('definable')
          ..isAbstract = true,

          class_('referable')
          ..isAbstract = true,

          class_('namer')
          ..isAbstract = true,

          class_('default_namer')
          ..extend = 'Namer',

          class_('numbered')
          ..members = [
            member('number')..type = 'int'
          ],
        ],
        part('built_in')
        ..enums = [
          enum_('built_in')
          ..hasLibraryScopedValues = true
          ..values = [
            'void_t',
            'bool_t',
            'int8_t', 'int16_t', 'int32_t', 'int64_t',
            'uint8_t', 'uint16_t', 'uint32_t', 'uint64_t',
            'float32_t', 'float64_t',
            'blob_t',
            'list_t',
          ]
        ],
        part('entity')
        ..classes = [
          class_('capnp_entity')
          ..extend = 'Entity'
          ..members = [
            member('id')
            ..doc = 'The [Id] for the entity'
            ..type = 'Id'
            ..access = RO..isFinal = true,
            member('namer')
            ..type = 'Namer'
            ..isStatic = true
            ..classInit = 'new DefaultNamer()',
          ],
        ],

        part('using')
        ..classes = [
          class_('using'),
        ],

        part('enum')
        ..classes = [
          class_('enum_value')
          ..extend = 'CapnpEntity'
          ..mixins = [ 'Numbered' ]
          ..members = [
          ],

          class_('enum')
          ..extend = 'CapnpEntity'
          ..implement = [ 'Definable', 'Referable' ]
          ..members = [
            member('values')
            ..type = 'List<EnumValue>'
            ..access = RO
            ..classInit = [],
          ],
        ],
        part('struct')
        ..classes = [
          class_('member')
          ..extend = 'CapnpEntity'
          ..mixins = [ 'Numbered' ]
          ..members = [
            member('id')
            ..doc = 'Represents the name',
            member('type'),
          ],
          class_('struct')
          ..extend = 'CapnpEntity'
          ..members = [
            member('members')..type = 'List<Member>'..classInit = [],
            member('structs')..type = 'List<Struct>'..classInit = [],
          ]
        ],
        part('union'),
        part('group'),
        part('interface')
        ..classes = [
          class_('method_decl')
          ..members = [
          ],

          class_('method')
          ..extend = 'CapnpEntity'
          ..mixins = [ 'Numbered' ]
          ..members = [
            member('method_decl')..type = 'MethodDecl',
          ],

          class_('interface')
          ..extend = 'CapnpEntity'
          ..members = [
            member('extend')..type = 'List<Interface>'..classInit = [],
            member('methods')..type = 'List<Method>'..classInit = [],
          ]
        ],
        part('generic'),
        part('constant')
        ..classes = [
          class_('constant')
          ..members = [
            member('type'),
            member('value'),
          ]
        ],
        part('import'),
        part('annotation'),
        part('schema')
        ..classes = [
          class_('schema')
          ..members = [
            member('interfaces')..type = 'List<Interface>',
            member('structs')..type = 'List<Struct>',
            member('constants')..type = 'List<Constant>',
          ]
        ],
      ]
    ];

  ebisu.generate();
}
