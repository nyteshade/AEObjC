#import <AEObjC/AEObjC.h>

@implementation AEObject
- (id)init
{
  self = [super init];
  if (self) {
  }
  return self;
}

- (void)dealloc
{
  [super free];
}
@end