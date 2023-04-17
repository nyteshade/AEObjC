#ifndef AE_LIST_H
#define AE_LIST_H

#import <AEObjC/AEObjC.h>

@class AEList;
@class AENode;

typedef void (*AENodeIterator)(AENode *node, AEULong index, AEList* list);
typedef id (*AENodeMapper)(AENode *node, AEULong index, AEList* list);
typedef AEBool (*AENodeFilter)(AENode *node, AEULong index, AEList* list);
typedef id (*AENodeReducer)(id previous, id current, AEULong index, AEList* list);
typedef AEBool (*AENodeComparator)(AENode *left, AENode *right);
typedef AEString* (*AENodePrinter)(AENode *node, const AEString* defaultContents);

@interface AENode: AEObject
{
  AENode* _next;
  AENode* _prev;
  id _data;
}

- (id)init;
- (id)initWithData:(id)data;
- (id)initWithNext:(AENode*)next;
- (id)initWithPrev:(AENode*)prev;
- (id)initWithNext:(AENode*)next data:(id)data;
- (id)initWithPrev:(AENode*)prev data:(id)data;
- (id)initWithNext:(AENode*)next prev:(AENode*)prev;
- (id)initWithNext:(AENode*)next prev:(AENode*)prev data:(id)data;

- (AENode*)next;
- (AENode*)prev;
- (id)data;

- (void)setNext:(AENode*)next;
- (void)setPrev:(AENode*)prev;
- (void)setData:(id)data;
@end


@interface AEList: AEObject
{
  AENode* _head;
  AENode* _tail;
}

- (id)init;
- (id)initWithItem:(id)item;
- (id)initWithList:(AEList*)list;

- (AENode*)head;
- (AENode*)tail;
- (AEList*)copy;

- (void)setHead:(AENode*)head;
- (void)setTail:(AENode*)tail;

- (void)addItem:(id)item;
- (void)addItems:(id)items, ...;
- (void)addList:(AEList*)list;

- (void)insertItem:(id)item before:(AENode*)node;
- (void)insertItem:(id)item after:(AENode*)node;

- (void)removeItem:(id)item;
- (void)removeItemAtIndex:(AEULong)index;
- (void)removeNode:(AENode*)node;
- (void)removeAll;

- (id)at:(AEULong)index;
- (id)itemAtIndex:(AEULong)index;
- (AENode*)nodeAtIndex:(AEULong)index;
- (AEInteger)indexOfItem:(id)item;
- (AEInteger)indexOfNode:(AENode*)node;

- (AEInteger)count;
- (AEBool)isEmpty;
- (AEBool)containsItem:(id)item;
- (AEBool)containsNode:(AENode*)node;

- (void)iterate:(AENodeIterator)iterator;
- (AEList*)filter:(AENodeFilter)filter;
- (AEList*)sort:(AENodeComparator)comparator;
- (AEList*)map:(AENodeMapper)mapper;
- (AEList*)reduce:(AENodeReducer)reducer 
          initial:(id)initial;
@end

#endif