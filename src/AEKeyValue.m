#import <AEObjC/AEObjC.h>

@implementation AEKeyValue
- (id)init
{
  self = [super init];
  if (self) {
    _type = AE_BYTE;
    _data.byte = 0;
    _length = 0;
  }
  return self;
}

+ (id)kvBool:(AEBool)boolean
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_BOOL;
  kv->_data.boolean = boolean;
  kv->_length = 1;
  return kv;
}

+ (id)kvByte:(AEByte)byte
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_BYTE;
  kv->_data.byte = byte;
  kv->_length = 1;
  return kv;
}

+ (id)kvInteger:(AEInteger)integer
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_INTEGER;
  kv->_data.integer = integer;
  kv->_length = 1;
  return kv;
}

+ (id)kvDecimal:(AEDecimal)decimal
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_DECIMAL;
  kv->_data.decimal = decimal;
  kv->_length = 1;
  return kv;  
}

+ (id)kvCString:(AEStrPtr)cString
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_CSTRING;
  kv->_data.string = cString;
  kv->_length = sizeof(AEStrPtr);
  return kv;
}

+ (id)kvString:(AEString*)string
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_AESTRING;
  kv->_data.aeString = string;
  kv->_length = sizeof(AEString*);
  return kv;
}

+ (id)kvPointer:(AEPointer)pointer
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_POINTER;
  kv->_data.pointer = pointer;
  kv->_length = sizeof(void*);
  return kv;
}

+ (id)kvCollection:(AECollection*)collection
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_COLLECTION;
  kv->_data.collection = collection;
  kv->_length = sizeof(AECollection*);
  return kv;
}

+ (id)kvMapNode:(AEMapNode*)mapNode
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_MAPNODE;
  kv->_data.mapNode = mapNode;
  kv->_length = sizeof(void*);
  return kv;
}

+ (id)kvMap:(AEMap*)map
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_MAP;
  kv->_data.map = map;
  kv->_length = sizeof(AEMap*);
  return kv;
}

+ (id)kvObject:(AEObject*)object
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_OBJECT;
  kv->_data.object = object;
  kv->_length = sizeof(AEObject*);
  return kv;
}

+ (id)kvUnknown:(id)unknown
{
  AEKeyValue* kv = [[AEKeyValue alloc] init];
  kv->_type = AE_UNKNOWN;
  kv->_data.unknown = unknown;
  kv->_length = sizeof(id);
  return kv;
}

- (AEBool)boolean
{
  return _data.boolean;
}

- (AEByte)byte
{
  return _data.byte;
}

- (AEInteger)integer
{
  return _data.integer;
}

- (AEDecimal)decimal
{
  return _data.decimal;
}

- (AEStrPtr)cString
{
  return _data.string;
}

- (AEString*)string
{
  return _data.aeString;
}

- (AEPointer)pointer
{
  return _data.pointer;
}

- (AECollection*)collection
{
  return _data.collection;
}

- (AEMapNode*)mapNode
{
  return _data.mapNode;
}

- (AEMap*)map
{
  return _data.map;
}

- (AEObject*)object
{
  return _data.object;
}

- (id)unknown
{
  return _data.unknown;
}

- (AEBool)isType:(AEKeyValueType)type
{
  return _type == type;
}

- (AEBool)isBoolean
{
  return _type == AE_BOOL;
}

- (AEBool)isByte
{
  return _type == AE_BYTE;
}

- (AEBool)isInteger
{
  return _type == AE_INTEGER;
}

- (AEBool)isDecimal
{
  return _type == AE_DECIMAL;
}

- (AEBool)isCString
{
  return _type == AE_CSTRING;
}

- (AEBool)isString
{
  return _type == AE_AESTRING;
}

- (AEBool)isPointer
{
  return _type == AE_POINTER;
}

- (AEBool)isCollection
{
  return _type == AE_COLLECTION;
}

- (AEBool)isMapNode
{
  return _type == AE_MAPNODE;
}

- (AEBool)isMap
{
  return _type == AE_MAP;
}

- (AEBool)isList
{
  return _type == AE_LIST;
}

- (AEBool)isObject
{
  return _type == AE_OBJECT;
}

- (AEBool)isUnknown
{
  return _type == AE_UNKNOWN;
}

- (AEString*)typeString
{
  return AEStringFromKeyValueType(_type);
}

- (AEKeyValueType)type
{
  return _type;
}

+ (AEBool)CompareKeyValues:(AEKeyValue*)left 
                      with:(AEKeyValue*)right
{
  if (left->_type != right->_type) {
    return AEFalse;
  }
  switch (left->_type) {
    case AE_BYTE:
      return left->_data.byte == right->_data.byte;
    case AE_INTEGER:
      return left->_data.integer == right->_data.integer;
    case AE_DECIMAL:
      return left->_data.decimal == right->_data.decimal;
    case AE_CSTRING:
      return strcmp(left->_data.string, right->_data.string) == 0;
    case AE_AESTRING:
      return [left->_data.aeString compare:right->_data.aeString] == 0;
    case AE_POINTER:
      return left->_data.pointer == right->_data.pointer;
    case AE_COLLECTION:
      return left->_data.collection == right->_data.collection;
    case AE_MAPNODE:
      return left->_data.mapNode == right->_data.mapNode;
    case AE_MAP:
      return left->_data.map == right->_data.map;
    case AE_LIST:
      return left->_data.list == right->_data.list;
    default:
      return AEFalse;
  }
}

+ (void)PrintKeyValue:(AEKeyValue*)kv
{
  AEString* buffer = [AEKeyValue SPrintKeyValue:kv into:NULL withTitle:NULL];
  printf("%s\n", [buffer cString]);
}

+ (AEString*)SPrintKeyValue:(AEKeyValue*)kv 
                       into:(char*)cStringBuffer 
                  withTitle:(AEString*)title
{
  char backupBuffer[2048];
  char* buffer = backupBuffer;

  if (cStringBuffer)
  {
    buffer = cStringBuffer;
  }

  if (title) {
    sprintf(buffer, "AEKeyValue Struct for %s", [title cString]);
  }

  switch (kv->_type) {
    case AE_BYTE:
      sprintf(buffer, "%d", kv->_data.byte);
      break;
    case AE_INTEGER:
      sprintf(buffer, "%d", kv->_data.integer);
      break;
    case AE_DECIMAL:
      sprintf(buffer, "%f", kv->_data.decimal);
      break;
    case AE_CSTRING:
      sprintf(buffer, "%s", kv->_data.string);
      break;
    case AE_AESTRING:
      sprintf(buffer, "%s", [kv->_data.aeString cString]);
      break;
    case AE_POINTER:
      sprintf(buffer, "%p", kv->_data.pointer);
      break;
    case AE_COLLECTION:
      //[AECollection PrintCollection:kv->_data.collection];
      sprintf(buffer, "%p", kv->_data.collection);
      break;
    case AE_MAPNODE:
      //[AEMapNode PrintMapNode:kv->_data.mapNode];
      sprintf(buffer, "%p", kv->_data.mapNode);
      break;
    case AE_MAP:
      //[AEMap PrintMap:kv->_data.map];
      sprintf(buffer, "%p", kv->_data.map);
      break;
    case AE_LIST:
      //[AEList PrintList:kv->_data.list];
      sprintf(buffer, "%p", kv->_data.list);
      break;
    default:
      break;
  }  

  return [AEString stringWithCString:buffer];
}
@end

AEString* AEStringFromKeyValueType(AEKeyValueType type)
{
  switch (type) {
    case AE_BYTE:
      return @"AE_BYTE";
    case AE_INTEGER:
      return @"AE_INTEGER";
    case AE_DECIMAL:
      return @"AE_DECIMAL";
    case AE_CSTRING:
      return @"AE_CSTRING";
    case AE_AESTRING:
      return @"AE_AESTRING";
    case AE_POINTER:
      return @"AE_POINTER";
    case AE_COLLECTION:
      return @"AE_COLLECTION";
    case AE_MAPNODE:
      return @"AE_MAPNODE";
    case AE_MAP:
      return @"AE_MAP";
    case AE_LIST:
      return @"AE_LIST";
    case AE_OBJECT:
      return @"AE_OBJECT";
    default:
      return @"AE_UNKNOWN";
  }
}

AEKeyValueType AEKeyValueTypeFromString(AEString* string)
{
  if ([string compare:@"AE_BYTE"]) 
    return AE_BYTE;
  else if ([string compare:@"AE_INTEGER"]) 
    return AE_INTEGER;
  else if ([string compare:@"AE_DECIMAL"])  
    return AE_DECIMAL;
  else if ([string compare:@"AE_CSTRING"])
    return AE_CSTRING;
  else if ([string compare:@"AE_AESTRING"])
    return AE_AESTRING;
  else if ([string compare:@"AE_POINTER"])
    return AE_POINTER;
  else if ([string compare:@"AE_COLLECTION"])
    return AE_COLLECTION;
  else if ([string compare:@"AE_MAPNODE"])
    return AE_MAPNODE;
  else if ([string compare:@"AE_MAP"])
    return AE_MAP;
  else if ([string compare:@"AE_LIST"])
    return AE_LIST;
  else if ([string compare:@"AE_OBJECT"])
    return AE_OBJECT;
  else
    return AE_UNKNOWN;  
}
