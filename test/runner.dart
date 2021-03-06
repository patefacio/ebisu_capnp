import 'package:logging/logging.dart';
import 'test_type.dart' as test_type;
import 'test_entity.dart' as test_entity;
import 'test_using.dart' as test_using;
import 'test_struct.dart' as test_struct;
import 'test_union.dart' as test_union;
import 'test_group.dart' as test_group;
import 'test_interface.dart' as test_interface;
import 'test_generic.dart' as test_generic;
import 'test_schema.dart' as test_schema;
import 'test_parser.dart' as test_parser;
import 'test_factories.dart' as test_factories;

main() {
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  test_type.main();
  test_entity.main();
  test_using.main();
  test_struct.main();
  test_union.main();
  test_group.main();
  test_interface.main();
  test_generic.main();
  test_schema.main();
  test_parser.main();
  test_factories.main();
}
