#import <AEObjC/AEObjC.h>
#import <stdarg.h>

@implementation AENode
- (id)init
{
  self = [super init];
  if (self) {
    _next = nil;
    _prev = nil;
  }
  return self;
}

- (id)initWithData:(id)data
{
  self = [super init];
  if (self) {
    _next = nil;
    _prev = nil;
    _data = data;
  }
  return self;
}

- (id)initWithNext:(AENode*)next
{
  self = [super init];
  if (self) {
    _next = next;
    _prev = nil;
    _data = nil;
  }
  return self;
}

- (id)initWithPrev:(AENode*)prev
{
  self = [super init];
  if (self) {
    _next = nil;
    _prev = prev;
    _data = nil;
  }
  return self;
}

- (id)initWithNext:(AENode*)next data:(id)data
{
  self = [super init];
  if (self) {
    _next = next;
    _prev = nil;
    _data = data;
  }
  return self;
}

- (id)initWithPrev:(AENode*)prev data:(id)data
{
  self = [super init];
  if (self) {
    _next = nil;
    _prev = prev;
    _data = data;
  }
  return self;
}

- (id)initWithNext:(AENode*)next prev:(AENode*)prev
{
  self = [super init];
  if (self) {
    _next = next;
    _prev = prev;
    _data = nil;
  }
  return self;
}

- (id)initWithNext:(AENode*)next prev:(AENode*)prev data:(id)data
{
  self = [super init];
  if (self) {
    _next = next;
    _prev = prev;
    _data = data;
  }
  return self;
}

- (AENode*)next
{
  return _next;
}

- (AENode*)prev
{
  return _prev;
}

- (id)data
{
  return _data;
}

- (void)setNext:(AENode*)next
{
  _next = next;
}

- (void)setPrev:(AENode*)prev
{
  _prev = prev;
}

- (void)setData:(id)data
{
  _data = data;
}
@end

@implementation AEList
- (id)init
{
  self = [super init];
  if (self) {
    _head = nil;
    _tail = nil;
  }
  return self;
}

- (id)initWithItem:(id)item
{
  self = [super init];
  if (self) {
    _head = [[AENode alloc] initWithData:item];
    _tail = _head;
  }
  return self;
}

- (id)initWithList:(AEList*)list
{
  self = [super init];
  if (self) {
    _head = [list head];
    _tail = [list tail];
  }
  return self;
}

- (AENode*)head
{
  return _head;
}

- (AENode*)tail
{
  return _tail;
}

- (AEList*)copy
{
  return [[AEList alloc] initWithList:self];
}

- (void)setHead:(AENode*)head
{
  _head = head;
}

- (void)setTail:(AENode*)tail
{
  _tail = tail;
}

- (void)addItem:(id)item
{
  AENode* node = [[AENode alloc] initWithData:item];
  if (_head == nil) {
    _head = node;
    _tail = node;
  } else {
    [_tail setNext:node];
    [node setPrev:_tail];
    _tail = node;
  }
}

- (void)addItems:(id)items, ...
{
  va_list args;
  id item;
  
  va_start(args, items);
  for (
    item = va_arg(args, id);
    item != nil;
    item = va_arg(args, id)
  ) {
    [self addItem:item];
  }
  va_end(args);
}

- (void)addList:(AEList*)list
{
  if (_head == nil) {
    _head = [list head];
    _tail = [list tail];
  } else {
    [_tail setNext:[list head]];
    [[list head] setPrev:_tail];
    _tail = [list tail];
  }
}

- (id)insertItem:(id)item before:(id)before
{
  AENode* node = _head;
  while (node != nil) {
    if ([node data] == before) {
      AENode* newNode = [[AENode alloc] initWithData:item];
      [newNode setNext:node];
      [newNode setPrev:[node prev]];
      if ([node prev] == nil) {
        _head = newNode;
      } else {
        [[node prev] setNext:newNode];
      }
      [node setPrev:newNode];
      return newNode;
    }
    node = [node next];
  }
  return nil;
}

- (id)insertItem:(id)item after:(id)after
{
  AENode* node = _head;
  while (node != nil) {
    if ([node data] == after) {
      AENode* newNode = [[AENode alloc] initWithData:item];
      [newNode setNext:[node next]];
      [newNode setPrev:node];
      if ([node next] == nil) {
        _tail = newNode;
      } else {
        [[node next] setPrev:newNode];
      }
      [node setNext:newNode];
      return newNode;
    }
    node = [node next];
  }
  return nil;
}

- (void)removeItem:(id)item
{
  AENode* node = _head;
  while (node != nil) {
    if ([node data] == item) {
      if ([node prev] == nil) {
        _head = [node next];
      } else {
        [[node prev] setNext:[node next]];
      }
      if ([node next] == nil) {
        _tail = [node prev];
      } else {
        [[node next] setPrev:[node prev]];
      }
      break;
    }
    node = [node next];
  }
}

- (void)removeItemAtIndex:(AEInteger)index
{
  AENode* node = _head;
  int i = 0;
  while (node != nil) {
    if (i == index) {
      if ([node prev] == nil) {
        _head = [node next];
      } else {
        [[node prev] setNext:[node next]];
      }
      if ([node next] == nil) {
        _tail = [node prev];
      } else {
        [[node next] setPrev:[node prev]];
      }
      break;
    }
    node = [node next];
    i++;
  }
}

- (void)removeNode:(AENode*)node
{
  if ([node prev] == nil) {
    _head = [node next];
  } else {
    [[node prev] setNext:[node next]];
  }
  if ([node next] == nil) {
    _tail = [node prev];
  } else {
    [[node next] setPrev:[node prev]];
  }
}

- (void)removeAllItems
{
  _head = nil;
  _tail = nil;
}

- (id)at:(AEInteger)index
{
  return [self itemAtIndex:index];
}

- (id)itemAtIndex:(AEInteger)index
{
  AENode* node = _head;
  int i = 0;
  while (node != nil) {
    if (i == index) {
      return [node data];
    }
    node = [node next];
    i++;
  }
  return nil;
}

- (AENode*)nodeAtIndex:(AEInteger)index
{
  AENode* node = _head;
  int i = 0;
  while (node != nil) {
    if (i == index) {
      return node;
    }
    node = [node next];
    i++;
  }
  return nil;
}

- (AEInteger)indexOfItem:(id)item
{
  AENode* node = _head;
  int i = 0;
  while (node != nil) {
    if ([node data] == item) {
      return i;
    }
    node = [node next];
    i++;
  }
  return -1;
}

- (AEInteger)indexOfNode:(AENode*)node
{
  AENode* n = _head;
  int i = 0;
  while (n != nil) {
    if (n == node) {
      return i;
    }
    n = [n next];
    i++;
  }
  return -1;
}

- (AEInteger)count
{
  AENode* node = _head;
  int i = 0;
  while (node != nil) {
    node = [node next];
    i++;
  }
  return i;
}

- (AEBool)isEmpty
{
  return _head == nil;
}

- (AEBool)containsItem:(id)item
{
  AENode* node = _head;
  while (node != nil) {
    if ([node data] == item) {
      return YES;
    }
    node = [node next];
  }
  return NO;
}

- (AEBool)containsNode:(AENode*)node
{
  AENode* n = _head;
  while (n != nil) {
    if (n == node) {
      return YES;
    }
    n = [n next];
  }
  return NO;
}

- (void)iterate:(AENodeIterator)iterator
{
  AENode* node = _head;
  AEUInteger index = 0;
  
  while (node != nil) {
    iterator(node, index, self);
    node = [node next];
    index++;
  }
}

- (AEList*)filter:(AENodeFilter)filter
{
  AEList* list = [[AEList alloc] init];
  AENode* node = _head;
  AEULong index = 0;
  while (node != nil) {
    if (filter(node, index++, self)) {
      [list addItem:[node data]];
    }
    node = [node next];
  }
  return list;
}

- (AEList*)sort:(AENodeComparator)comparator
{
  AEList* list = [[AEList alloc] init];
  AENode* node = _head;
  while (node != nil) {
    [list addItem:[node data]];
    node = [node next];
  }
  [list sort:comparator];
  return list;
}

- (AEList*)map:(AENodeMapper)mapper
{
  AEList* list = [[AEList alloc] init];
  AENode* node = _head;
  AEULong index = 0;
  while (node != nil) {
    [list addItem:mapper(node, index++, self)];
    node = [node next];
  }
  return list;
}

- (AEList*)reduce:(AENodeReducer)reducer initial:(id)initial
{
  AEList* list = [[AEList alloc] init];
  AENode* node = _head;
  AEULong index = 0;
  id previous = initial;
  while (node != nil) {
    previous = reducer(previous, [node data], index++, list);
    node = [node next];
  }
  return list;
}

@end