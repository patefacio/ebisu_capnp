import 'package:test/test.dart';
import 'package:logging/logging.dart';
import 'test_built_in.dart' as test_built_in;
import 'test_enum.dart' as test_enum;
import 'test_entity.dart' as test_entity;
import 'test_using.dart' as test_using;
import 'test_struct.dart' as test_struct;
import 'test_union.dart' as test_union;
import 'test_group.dart' as test_group;
import 'test_interface.dart' as test_interface;
import 'test_generic.dart' as test_generic;
import 'test_constant.dart' as test_constant;
import 'test_import.dart' as test_import;
import 'test_annotation.dart' as test_annotation;
import 'test_schema.dart' as test_schema;

void testCore(Configuration config) {
  unittestConfiguration = config;
  main();
}

main() {
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  test_built_in.main();
  test_enum.main();
  test_entity.main();
  test_using.main();
  test_struct.main();
  test_union.main();
  test_group.main();
  test_interface.main();
  test_generic.main();
  test_constant.main();
  test_import.main();
  test_annotation.main();
  test_schema.main();
}
