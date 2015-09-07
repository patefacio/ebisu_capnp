import "dart:io";
import "package:path/path.dart" as path;
import "package:id/id.dart";
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

  final builtIns = [
    'void_t',
    'bool_t',
    'int8_t', 'int16_t', 'int32_t', 'int64_t',
    'u_int8_t', 'u_int16_t', 'u_int32_t', 'u_int64_t',
    'float32_t', 'float64_t',
    'text_t', 'data_t',
    'list_t',
  ];

  _topDir = path.dirname(path.dirname(here));
  useDartFormatter = true;
  System ebisu = system('ebisu_capnp')
    ..rootPath = _topDir
    ..includesHop = true
    ..license = 'boost'
    ..pubSpec.homepage = 'https://github.com/patefacio/ebisu_capnp'
    ..doc = purpose
    ..testLibraries = [
      library('test_type')..imports = ['../lib/capnp_schema.dart'],
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
      library('test_parser')..imports = ['../lib/capnp_schema.dart'],
    ]
    ..libraries = [

      library('capnp_generation'),

      library('capnp_parser')
      ..imports = [
        'package:petitparser/petitparser.dart',
      ]
      ..parts = [
        part('parser')
        ..classes = [
          class_('capnp_grammar')
          ..extend = 'GrammarParser',

          class_('capnp_grammar_definition')
          ..extend = 'GrammarDefinition',

          class_('capnp_parser')
          ..extend = 'GrammarParser',

          class_('capnp_parser_definition')
          ..extend = 'CapnpGrammarDefinition',
        ],
      ],

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

          class_('reference')
          ..implement = ['Typed']
          ..isImmutable = true
          ..members = [
            member('type')..access = RO,
          ],

          class_('namer')
          ..isAbstract = true,

          class_('default_namer')
          ..extend = 'Namer',

          class_('numbered')
          ..members = [
            member('number')..type = 'int'
          ],
        ],

        part('type')
        ..withCustomBlock((CodeBlock cb) {
          cb.snippets.add(
              br(builtIns.map((var builtIn) {
                  final base = builtIn.replaceAll('_t', '');
                  final baseId = idFromString(base);
                  final constVar = idFromString(builtIn).camel;
                  final typeClassId = idFromString('idl_$base');
                  final typeClass = class_(typeClassId)
                    ..doc = 'Built in type for *${baseId.capCamel}*'
                    ..extend = 'BuiltInType'
                    ..includesProtectBlock = false
                    ..withCustomBlock((CodeBlock cb) {
                      cb
                        ..snippets.add('''
const ${typeClassId.capCamel}();
String get type => ':${baseId.capCamel}';
BuiltIn get builtInType => BuiltIn.$constVar;
''');
                    });
                  return '''
${chomp(typeClass.definition, true)}

/// Single instance of ${baseId.capCamel} type
///
/// Use this to specify *$base* IDL types when modeling
const $constVar = const ${typeClassId.capCamel}();
''';
                })));
        })
        ..enums = [
          enum_('built_in')
          ..values = builtIns
        ]
        ..classes = [

          class_('typed')
          ..doc = 'Establishes base class for *capnp* *IDL* types'
          ..isAbstract = true
          ..includesProtectBlock = false
          ..withCustomBlock((CodeBlock cb) {
            cb.snippets.add('''
const Typed();
String get type;
''');
          }),

          class_('built_in_type')
          ..doc = 'Establishes a base type for *capnp* *IDL* built-ins'
          ..isAbstract = true
          ..includesProtectBlock = false
          ..extend = 'Typed'
          ..withCustomBlock((CodeBlock cb) {
            cb.snippets.add('''
const BuiltInType();
BuiltIn get builtInType;
''');
          }),
        ],

        part('entity')
        ..classes = [
          class_('capnp_entity')
          ..isAbstract = true
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

          class_('using_statement')..isAbstract = true,

          class_('using')
          ..implement = [ 'Definable', 'UsingStatement' ]
          ..members = [
            member('reference')..access = RO
          ],
          class_('alias_using')
          ..extend = 'CapnpEntity'
          ..implement = [ 'UsingStatement' ]
          ..members = [
            member('using')..type = 'Using'..access = RO
          ],
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
          ..implement = [ 'Definable', 'Referable' ]
          ..mixins = [ 'Numbered' ]
          ..members = [
            member('type')..type = 'Typed',
            member('union')..doc = '''
If present, the union it belongs to.

For an anonymous union use empty string ""
''',
            member('default_value')..type = 'dynamic'..access = RO,
          ],

          class_('struct')
          ..extend = 'CapnpEntity'
          ..implement = [ 'Definable', 'Referable' ]
          ..members = [
            member('members')..type = 'List<Member>'..classInit = []..access = RO,
            member('structs')..type = 'List<Struct>'..classInit = [],
          ]
        ],

        part('union')
        ..classes = [
          class_('union')
          ..members = [
            member('name')..doc = 'Name of union or null if anonymous',
            member('members')..type = 'List<Member>'..classInit = []..access = RO,
          ]
        ],

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
          ..extend = 'CapnpEntity'
          ..implement = [ 'Definable', 'Referable' ]
          ..members = [
            member('type')..access = RO..type = 'Typed',
            member('value')..access = RO,
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
