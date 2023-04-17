#ifndef AE_BITSET_H
#define AE_BITSET_H

#import <objc/objc.h>

@interface AEBitSetConversion: AEObject {
  unsigned char _string[1024];
  unsigned long _integer;
}
- (id)init;

- (unsigned char*)string;
- (unsigned long)integer;
- (void)setString:(unsigned char*)string;
- (void)setInteger:(unsigned long)integer;
@end

@interface AEBitSet: Object {
  unsigned char* _bits;
  unsigned int _nbits;
}

- (id)init;
- (id)initWithBits:(unsigned int)bitCount;

- (void)set:(unsigned int)bit;
- (void)clear:(unsigned int)bit;
- (void)clearAll;
- (void)invert;
- (unsigned int)test:(unsigned int)bit;
- (void)print;
- (void)printWithSpacingEveryFour:(AEBool)everyFour 
                    andEveryEight:(AEBool)everyEight;
- (void)destroy;
- (unsigned long)toNumber;
- (AEBitSetConversion*)convert:(AEBitSet*)bitset;
- (void)calculateFromBinary:(const char*)fromBinaryString;
- (void)calculateFromNumber:(long)fromNumber;

@end

#endif