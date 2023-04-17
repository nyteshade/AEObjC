#ifndef AE_KEYVALUE_H
#define AE_KEYVALUE_H

#import <AEObjC/AEObjC.h>

@class AECollection;
@class AEMapNode;
@class AEMap;
@class AEList;
@class AEString;
@class AEKeyValue;

typedef enum KeyValueType {
  AE_BOOL = 0,
  AE_BYTE,
  AE_INTEGER,
  AE_DECIMAL,
  AE_CSTRING,
  AE_AESTRING,
  AE_POINTER,
  AE_COLLECTION,
  AE_MAPNODE,
  AE_MAP,
  AE_LIST,
  AE_OBJECT,
  AE_UNKNOWN
} AEKeyValueType;

typedef union {
  AEBool boolean;
  AEByte byte;
  AEInteger integer;
  AEDecimal decimal;
  AEStrPtr string;
  AEString* aeString;
  AEPointer pointer;
  AECollection* collection;
  AEMapNode* mapNode;
  AEMap* map;
  AEList* list;
  AEObject* object;
  id unknown;
} AEKeyValueUnion;

@interface AEKeyValue: AEObject
{
  AEKeyValueType _type;
  AEKeyValueUnion _data;
  AEULong _length;
}

+ (id)kvBool:(AEBool)boolean;
+ (id)kvByte:(AEByte)byte;
+ (id)kvInteger:(AEInteger)integer;
+ (id)kvDecimal:(AEDecimal)decimal;
+ (id)kvCString:(AEStrPtr)cString;
+ (id)kvString:(AEString*)string;
+ (id)kvPointer:(AEPointer)pointer;
+ (id)kvCollection:(AECollection*)collection;
+ (id)kvMapNode:(AEMapNode*)mapNode;
+ (id)kvMap:(AEMap*)map;
+ (id)kvObject:(AEObject*)object;
+ (id)kvUnknown:(id)unknown;

- (AEByte)byte;
- (AEBool)boolean;
- (AEInteger)integer;
- (AEDecimal)decimal;
- (AEStrPtr)cString;
- (AEString*)string;
- (AEPointer)pointer;
- (AECollection*)collection;
- (AEMapNode*)mapNode;
- (AEMap*)map;
- (AEObject*)object;
- (id)unknown;

- (AEBool)isType:(AEKeyValueType)type;
- (AEBool)isBoolean;
- (AEBool)isByte;
- (AEBool)isInteger;
- (AEBool)isDecimal;
- (AEBool)isCString;
- (AEBool)isString;
- (AEBool)isPointer;
- (AEBool)isCollection;
- (AEBool)isMapNode;
- (AEBool)isMap;
- (AEBool)isList;
- (AEBool)isObject;
- (AEBool)isUnknown;

- (AEString*)typeString;
- (AEKeyValueType)type;

+ (AEBool)CompareKeyValues:(AEKeyValue*)left with:(AEKeyValue*)right;
+ (void)PrintKeyValue:(AEKeyValue*)kv;
+ (AEString*)SPrintKeyValue:(AEKeyValue*)kv 
                       into:(char*)cStringBuffer
                  withTitle:(AEString*)title;
@end

AEString* AEStringFromKeyValueType(AEKeyValueType type);
AEKeyValueType AEKeyValueTypeFromString(AEString* string);

#endif