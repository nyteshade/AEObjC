#ifndef AE_STRING_H
#define AE_STRING_H

#import <objc/Object.h>
#import <objc/NXConstStr.h>
#import <AEObjC/AETypes.h>
#import <stddef.h>

@interface AEString: AEObject {
  char* _string;
  AEULong _length;
}

- (id)initWithCString:(const char*)cstring;
- (id)initWithPascalString:(unsigned char*)pstring;
- (id)initWithAEString:(AEString*)aestring;

+ (id)fromCString:(const char*)cstring;
+ (id)fromPString:(const unsigned char*)pstring;
+ (id)fromAEString:(AEString*)source;

- (char)charAt:(AEULong)index;
- (int)compare:(AEString*)other;
- (int)compareInsensitive:(AEString*)other;
- (AEString*)copy;
- (AEString*)concat:(AEString*)other;
- (AEString*)substringFrom:(AEULong)start 
                withLength:(AEULong)length;
- (AEString*)reverse;
- (AEString*)toLower;
- (AEString*)toUpper;
- (AEString*)trim;
- (AEString*)trimLeft;
- (AEString*)trimRight;
/*- (AECollection*)splitOn:(char)delimiter;*/
- (AEULong)length;
- (AEULong)count;
- (const char*)cString;
- (unsigned char*)pascalString;

- (void)dealloc;

+ (AEBool)compareLeft:(AEString*)left 
              toRight:(AEString*)right;
+ (AEBool)compareLeft:(AEString*)left 
              toRight:(AEString*)right
      caseInsensitive:(AEBool)caseInsensitive;              
@end

@interface AEConstantString: AEString
@end

extern int __NSConstantString_tag;

#endif