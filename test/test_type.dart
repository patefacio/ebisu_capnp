library ebisu_capnp.test_type;

import '../lib/capnp_schema.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>
// end <additional imports>

final _logger = new Logger('test_type');

// custom <library test_type>
// end <library test_type>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  test('built-in types', () {
    expect(voidT.type, 'Void');
    expect(boolT.type, 'Bool');
    expect(int8T.type, 'Int8');
    expect(int16T.type, 'Int16');
    expect(int32T.type, 'Int32');
    expect(int64T.type, 'Int64');
    expect(uInt8T.type, 'UInt8');
    expect(uInt16T.type, 'UInt16');
    expect(uInt32T.type, 'UInt32');
    expect(uInt64T.type, 'UInt64');
    expect(float32T.type, 'Float32');
    expect(float64T.type, 'Float64');
    expect(textT.type, 'Text');
    expect(dataT.type, 'Data');
    expect(listT.type, 'List');
  });

// end <main>
}
