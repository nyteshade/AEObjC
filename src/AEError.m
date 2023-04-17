#import <AEObjC/AEObjC.h>

@implementation AEError 
- (id)initWithMessage:(AEString*)message code:(AEInteger)code
{
  if (self = [super init])
  {
    _message = message;
    _code = code;
  }
  return self;
}

+ (id)errorWithMessage:(AEString*)message code:(AEInteger)code
{
  return [[AEError alloc] initWithMessage:message code:code];
}

+ (AEError*)generalError
{
  return [AEError errorWithMessage:@"General error" code:0];
}

+ (AEError*)keyValueTypeMismatchError
{
  return [AEError errorWithMessage:@"Key value type mismatch" code:1];
}
@end