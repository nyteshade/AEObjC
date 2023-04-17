#ifndef AE_ERROR_H
#define AE_ERROR_H

#import <AEObjC/AEObjC.h>

@interface AEError: AEObject
{
  AEString* _message;
  AEInteger _code;
}
- (id)initWithMessage:(AEString*)message code:(AEInteger)code;
+ (id)errorWithMessage:(AEString*)message code:(AEInteger)code;

+ (AEError*)generalError;
+ (AEError*)keyValueTypeMismatchError;
@end

#endif