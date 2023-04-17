#ifndef AE_COLLECTION_H
#define AE_COLLECTION_H

#import <AEObjC/AEObject.h>
#import <AEObjC/AETypes.h>
#import <AEObjC/AEKeyValue.h>
#import <AEObjC/AEList.h>
#import <AEObjC/AEMap.h>
#import <AEObjC/AEError.h>

@interface AECollection: AEObject
{
  AEList* _list;
}

- (id)init;
- (id)initWithList:(AEList*)list;

- (void)add:(AEKeyValue*)value;
- (void)addBool:(AEBool)value;
- (void)addByte:(AEByte)value;
- (void)addInteger:(AEInteger)value;
- (void)addDecimal:(AEDecimal)value;
- (void)addString:(AEString*)value;
- (void)addCString:(AEStrPtr)value;
- (void)addPointer:(AEPointer)value;
- (void)addObject:(AEObject*)value;
- (void)addList:(AEList*)value;
- (void)addCollection:(AECollection*)value;
- (void)addMapNode:(AEMapNode*)value;
- (void)addMap:(AEMap*)value;
- (void)addObject:(AEObject*)value;

- (AEULong)count;

- (AEKeyValue*)findBool:(AEBool)value;
- (AEKeyValue*)findByte:(AEByte)value;
- (AEKeyValue*)findInteger:(AEInteger)value;
- (AEKeyValue*)findDecimal:(AEDecimal)value;
- (AEKeyValue*)findString:(AEString*)value;
- (AEKeyValue*)findCString:(AEStrPtr)value;
- (AEKeyValue*)findPointer:(AEPointer)value;
- (AEKeyValue*)findObject:(AEObject*)value;
- (AEKeyValue*)findList:(AEList*)value;
- (AEKeyValue*)findCollection:(AECollection*)value;
- (AEKeyValue*)findMapNode:(AEMapNode*)value;
- (AEKeyValue*)findMap:(AEMap*)value;
- (AEKeyValue*)findObject:(AEObject*)value;

- (AEKeyValue*)at:(AEUInteger)index;
- (AEBool)boolAt:(AEUInteger)index error:(AEError**)error;
- (AEByte)byteAt:(AEUInteger)index error:(AEError**)error;
- (AEInteger)integerAt:(AEUInteger)index error:(AEError**)error;
- (AEDecimal)decimalAt:(AEUInteger)index error:(AEError**)error;
- (AEString*)stringAt:(AEUInteger)index error:(AEError**)error;
- (AEStrPtr)cStringAt:(AEUInteger)index error:(AEError**)error;
- (AEPointer)pointerAt:(AEUInteger)index error:(AEError**)error;
- (AEList*)listAt:(AEUInteger)index error:(AEError**)error;
- (AECollection*)collectionAt:(AEUInteger)index error:(AEError**)error;
- (AEMapNode*)mapNodeAt:(AEUInteger)index error:(AEError**)error;
- (AEMap*)mapAt:(AEUInteger)index error:(AEError**)error;
- (AEObject*)objectAt:(AEUInteger)index error:(AEError**)error;
@end

#endif