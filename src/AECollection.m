#import <AEObjC/AEObjC.h>

AEBool findBoolean(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isBoolean]; }
AEBool findByte(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isByte]; }
AEBool findInteger(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isInteger]; }
AEBool findDecimal(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isDecimal]; }
AEBool findString(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isString]; }
AEBool findCString(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isCString]; }
AEBool findCollection(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isCollection]; }
AEBool findPointer(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isPointer]; }
AEBool findMapNode(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isMapNode]; }
AEBool findMap(AENode *node, AEULong index, AEList* list) 
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isMap]; }
AEBool findList(AENode *node, AEULong index, AEList* list)
{ return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isList]; }
AEBool _findObject(AENode *node, AEULong index, AEList* list)
  { return [[node data] isKindOf: [AEKeyValue class]] && [(AEKeyValue*)[node data] isObject]; }

@implementation AECollection 
- (id)init
{
  if (self = [super init])
  {
    _list = [AEList list];
  }
  return self;
}

- (id)initWithList:(AEList*)list
{
  if (self = [super init])
  {
    _list = list;
  }
  return self;
}

- (void)add:(AEKeyValue*)value
{
  [_list add:value];
}

- (void)addBool:(AEBool)value
{
  [self add:[AEKeyValue kvBool:value]];
}

- (void)addByte:(AEByte)value
{
  [self add:[AEKeyValue kvByte:value]];
}

- (void)addInteger:(AEInteger)value
{
  [self add:[AEKeyValue kvInteger:value]];
}

- (void)addDecimal:(AEDecimal)value
{
  [self add:[AEKeyValue kvDecimal:value]];
}

- (void)addString:(AEString*)value
{
  [self add:[AEKeyValue kvString:value]];
}

- (void)addCString:(AEStrPtr)value
{
  [self add:[AEKeyValue kvCString:value]];
}

- (void)addPointer:(AEPointer)value
{
  [self add:[AEKeyValue kvPointer:value]];
}

- (void)addObject:(AEObject*)value
{
  [self add:[AEKeyValue kvObject:value]];
}

- (void)addList:(AEList*)value
{
  [self add:[AEKeyValue kvList:value]];
}

- (void)addCollection:(AECollection*)value
{
  [self add:[AEKeyValue kvCollection:value]];
}

- (void)addMapNode:(AEMapNode*)value
{
  [self add:[AEKeyValue kvMapNode:value]];
}

- (void)addMap:(AEMap*)value
{
  [self add:[AEKeyValue kvMap:value]];
}

- (AEULong)count
{
  return [_list count];
}

- (AEKeyValue*)findBool:(AEBool)value
{
  AEList* filtered = [_list filter:findBoolean];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findByte:(AEByte)value
{
  AEList* filtered = [_list filter:findByte];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findInteger:(AEInteger)value
{
  AEList* filtered = [_list filter:findInteger];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findDecimal:(AEDecimal)value
{
  AEList* filtered = [_list filter:findDecimal];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findString:(AEString*)value
{
  AEList* filtered = [_list filter:findString];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findCString:(AEStrPtr)value
{
  AEList* filtered = [_list filter:findCString];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findPointer:(AEPointer)value
{
  AEList* filtered = [_list filter:findPointer];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findObject:(AEObject*)value
{
  AEList* filtered = [_list filter:_findObject];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findList:(AEList*)value
{
  AEList* filtered = [_list filter:findList];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findCollection:(AECollection*)value
{
  AEList* filtered = [_list filter:findCollection];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findMapNode:(AEMapNode*)value
{
  AEList* filtered = [_list filter:findMapNode];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)findMap:(AEMap*)value
{
  AEList* filtered = [_list filter:findMap];
  return filtered ? ([filtered count] ? [filtered at:0] : nil) : nil;
}

- (AEKeyValue*)at:(AEUInteger)index
{
  return [_list at:index];
}

- (AEBool)boolAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_BOOL])
    return [kv boolean];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return NO;
  }
}

- (AEByte)byteAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_BYTE])
    return [kv byte];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return 0;
  }
}

- (AEInteger)integerAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_INTEGER])
    return [kv integer];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return 0;
  }
}

- (AEDecimal)decimalAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_DECIMAL])
    return [kv decimal];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return 0;
  }
}

- (AEString*)stringAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_AESTRING])
    return [kv string];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return nil;
  }
}

- (AEStrPtr)cStringAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_CSTRING])
    return [kv cString];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return nil;
  }
}

- (AEPointer)pointerAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_POINTER])
    return [kv pointer];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return nil;
  }
}

- (AEList*)listAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_LIST])
    return [kv list];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return nil;
  }
}

- (AECollection*)collectionAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_COLLECTION])
    return [kv collection];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return nil;
  }
}

- (AEMapNode*)mapNodeAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_MAPNODE])
    return [kv mapNode];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return nil;
  }
}

- (AEMap*)mapAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_MAP])
    return [kv map];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return nil;
  }
}

- (AEObject*)objectAt:(AEUInteger)index error:(AEError**)error
{
  AEKeyValue* kv = [_list at:index];
  if (kv && [kv isType:AE_OBJECT])
    return [kv object];
  else
  {
    if (error)
      *error = [AEError keyValueTypeMismatchError];
    return nil;
  }
}

@end