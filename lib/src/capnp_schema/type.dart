part of ebisu_capnp.capnp_schema;

enum BuiltIn {
  voidT,
  boolT,
  int8T,
  int16T,
  int32T,
  int64T,
  uInt8T,
  uInt16T,
  uInt32T,
  uInt64T,
  float32T,
  float64T,
  textT,
  dataT,
  listT
}

/// Establishes base class for *capnp* *IDL* types
abstract class Typed {
  const Typed();
  String get type;
}

/// Establishes base class for value associated with type
abstract class Valued {
  // custom <class Valued>
  // end <class Valued>

  const Valued();
  String get value;
}

/// Establishes a base type for *capnp* *IDL* built-ins
abstract class BuiltInType extends Typed {
  const BuiltInType();
  BuiltIn get builtInType;
}

abstract class UserDefinedType implements Typed {
  // custom <class UserDefinedType>
  // end <class UserDefinedType>

}

abstract class Literal implements Typed, Valued {
  // custom <class Literal>
  // end <class Literal>

}

class LiteralBuiltInType extends Literal {
  BuiltInType type;
  dynamic value;

  // custom <class LiteralBuiltInType>
  // end <class LiteralBuiltInType>

}

class LiteralUserDefinedType extends Literal {
  UserDefinedType type;
  dynamic value;

  // custom <class LiteralUserDefinedType>
  // end <class LiteralUserDefinedType>

}

class LiteralList extends Literal {
  List<Literal> literals = [];

  // custom <class LiteralList>
  // end <class LiteralList>

}

// custom <part type>

final _startsCapital = new RegExp(r'^[A-Z]');
_typeNameCheck(String type) {
  if (!type.contains(_startsCapital)) {
    throw new FormatException('capnp *Type Names* must begin with a capital letter: $type');
  }
}

// end <part type>

/// Built in type for *Void*
class IdlVoid extends BuiltInType {
  const IdlVoid();
  String get type => 'Void';
  BuiltIn get builtInType => BuiltIn.voidT;
}

/// Single instance of Void type
///
/// Use this to specify *void* IDL types when modeling
const voidT = const IdlVoid();

/// Built in type for *Bool*
class IdlBool extends BuiltInType {
  const IdlBool();
  String get type => 'Bool';
  BuiltIn get builtInType => BuiltIn.boolT;
}

/// Single instance of Bool type
///
/// Use this to specify *bool* IDL types when modeling
const boolT = const IdlBool();

/// Built in type for *Int8*
class IdlInt8 extends BuiltInType {
  const IdlInt8();
  String get type => 'Int8';
  BuiltIn get builtInType => BuiltIn.int8T;
}

/// Single instance of Int8 type
///
/// Use this to specify *int8* IDL types when modeling
const int8T = const IdlInt8();

/// Built in type for *Int16*
class IdlInt16 extends BuiltInType {
  const IdlInt16();
  String get type => 'Int16';
  BuiltIn get builtInType => BuiltIn.int16T;
}

/// Single instance of Int16 type
///
/// Use this to specify *int16* IDL types when modeling
const int16T = const IdlInt16();

/// Built in type for *Int32*
class IdlInt32 extends BuiltInType {
  const IdlInt32();
  String get type => 'Int32';
  BuiltIn get builtInType => BuiltIn.int32T;
}

/// Single instance of Int32 type
///
/// Use this to specify *int32* IDL types when modeling
const int32T = const IdlInt32();

/// Built in type for *Int64*
class IdlInt64 extends BuiltInType {
  const IdlInt64();
  String get type => 'Int64';
  BuiltIn get builtInType => BuiltIn.int64T;
}

/// Single instance of Int64 type
///
/// Use this to specify *int64* IDL types when modeling
const int64T = const IdlInt64();

/// Built in type for *UInt8*
class IdlUInt8 extends BuiltInType {
  const IdlUInt8();
  String get type => 'UInt8';
  BuiltIn get builtInType => BuiltIn.uInt8T;
}

/// Single instance of UInt8 type
///
/// Use this to specify *u_int8* IDL types when modeling
const uInt8T = const IdlUInt8();

/// Built in type for *UInt16*
class IdlUInt16 extends BuiltInType {
  const IdlUInt16();
  String get type => 'UInt16';
  BuiltIn get builtInType => BuiltIn.uInt16T;
}

/// Single instance of UInt16 type
///
/// Use this to specify *u_int16* IDL types when modeling
const uInt16T = const IdlUInt16();

/// Built in type for *UInt32*
class IdlUInt32 extends BuiltInType {
  const IdlUInt32();
  String get type => 'UInt32';
  BuiltIn get builtInType => BuiltIn.uInt32T;
}

/// Single instance of UInt32 type
///
/// Use this to specify *u_int32* IDL types when modeling
const uInt32T = const IdlUInt32();

/// Built in type for *UInt64*
class IdlUInt64 extends BuiltInType {
  const IdlUInt64();
  String get type => 'UInt64';
  BuiltIn get builtInType => BuiltIn.uInt64T;
}

/// Single instance of UInt64 type
///
/// Use this to specify *u_int64* IDL types when modeling
const uInt64T = const IdlUInt64();

/// Built in type for *Float32*
class IdlFloat32 extends BuiltInType {
  const IdlFloat32();
  String get type => 'Float32';
  BuiltIn get builtInType => BuiltIn.float32T;
}

/// Single instance of Float32 type
///
/// Use this to specify *float32* IDL types when modeling
const float32T = const IdlFloat32();

/// Built in type for *Float64*
class IdlFloat64 extends BuiltInType {
  const IdlFloat64();
  String get type => 'Float64';
  BuiltIn get builtInType => BuiltIn.float64T;
}

/// Single instance of Float64 type
///
/// Use this to specify *float64* IDL types when modeling
const float64T = const IdlFloat64();

/// Built in type for *Text*
class IdlText extends BuiltInType {
  const IdlText();
  String get type => 'Text';
  BuiltIn get builtInType => BuiltIn.textT;
}

/// Single instance of Text type
///
/// Use this to specify *text* IDL types when modeling
const textT = const IdlText();

/// Built in type for *Data*
class IdlData extends BuiltInType {
  const IdlData();
  String get type => 'Data';
  BuiltIn get builtInType => BuiltIn.dataT;
}

/// Single instance of Data type
///
/// Use this to specify *data* IDL types when modeling
const dataT = const IdlData();

/// Built in type for *List*
class IdlList extends BuiltInType {
  const IdlList();
  String get type => 'List';
  BuiltIn get builtInType => BuiltIn.listT;
}

/// Single instance of List type
///
/// Use this to specify *list* IDL types when modeling
const listT = const IdlList();
