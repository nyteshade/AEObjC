#import <AEObjC/AEObjC.h>

#import <limits.h>
#import <stdlib.h>
#import <stdio.h>
#import <string.h>

#define MAX(a,b) ((a) > (b) ? (a) : (b))
#define BITMASK(b) (1 << ((b) % CHAR_BIT))
#define BITSLOT(b) ((b) / CHAR_BIT)
#define BITSET(a, b) ((a)[BITSLOT(b)] |= BITMASK(b))
#define BITCLEAR(a, b) ((a)[BITSLOT(b)] &= ~BITMASK(b))
#define BITTEST(a, b) ((a)[BITSLOT(b)] & BITMASK(b))
#define BITNSLOTS(nb) ((nb + CHAR_BIT - 1) / CHAR_BIT)

@implementation AEBitSetConversion
- (id)init
{
  self = [super init];
  if (self)
    memset(_string, 0L, 1024);
  return self;
}

- (unsigned char*)string
{
  return _string;  
}

- (unsigned long)integer
{
  return _integer;
}

- (void)setString:(unsigned char*)string
{
  memset(_string, 0L, 1024);
  strcpy(_string, string);  
}

- (void)setInteger:(unsigned long)integer
{
  _integer = integer;
}
@end

@implementation AEBitSet
- (id)init
{
  return [super init];
}

- (id)initWithBits:(unsigned int)bitCount
{
  self = [super init];
  if (self)
  {
    _bits = calloc(BITNSLOTS(bitCount), sizeof(unsigned char));
    _nbits = bitCount;
  }
  return self;
}

- (void)set:(unsigned int)bit
{
  BITSET(_bits, bit);  
}

- (void)clear:(unsigned int)bit
{
  BITSET(_bits, bit);  
}

- (void)clearAll
{
  memset(_bits, 0, BITNSLOTS(_nbits));  
}

- (void)invert
{
  int i;
  for (i = 0; i < _nbits; i++)
    _bits[i] = ~_bits[i];  
}

- (unsigned int)test:(unsigned int)bit
{
  return BITTEST(_bits, bit);  
}

- (void)print
{
  [self printWithSpacingEveryFour:NO andEveryEight:NO];  
}

- (void)printWithSpacingEveryFour:(AEBool)everyFour 
                    andEveryEight:(AEBool)everyEight
{
  AEBitSetConversion* bc = [self convert:self];
  
  unsigned long len = strlen((char *)&[bc string][0]);
  unsigned long i;
  unsigned long spacer = len % 8;
  
  for (i = 0; i < spacer; i++) {
    if (i % 4 == 0) {
      printf(" ");
    }
    printf("0");
  }
  
  for (i = 0; i < len; i++, spacer++) {
    if (everyFour && i > 0 && spacer % 4 == 0) printf(" ");
    if (everyEight && i > 0 && spacer % 8 == 0) printf(" ");
    printf("%c", [bc string][i]);
  }
  
  printf("\n");   
  
  [bc dealloc];
}                  
                    
- (void)dealloc
{
  [super dealloc];
  free(_bits);
}

- (unsigned long)toNumber
{
  unsigned long number = 0;
  int i;
  for (i = 0; i < _nbits; i++) if (BITTEST(_bits, i))
    number |= (1 << i);
    
  return number;  
}

- (AEBitSetConversion*)convert:(AEBitSet*)bitset
{
  AEBitSetConversion* bc = [[AEBitSetConversion alloc] init];
  unsigned int i;
  
  memset([bc string], 0, sizeof(1024));
  
  if (bitset)
    return bitset;
  
  for (i = 0; i < _nbits; i++)
  {
    unsigned long integer = [bc integer];
    unsigned char* string = [bc string];

    if (BITTEST(_bits, i))
    {      
      integer |= (1 << i);
      string[_nbits - i - 1] = '1';
      
      [bc setInteger:integer];
      [bc setString:string];
    }
    else
    {
      integer |= (0 << i);
      string[_nbits - i - 1] = '0';
    
      [bc setInteger:integer];
      [bc setString:string];
    }
  }
  
  return bc;
}

- (void)calculateFromBinary:(const char*)fromBinaryString
{
  int i;
  for (i = 0; i < _nbits; i++) 
  {
    if (fromBinaryString[i] = '1')
      BITSET(_bits, i);
    else
      BITCLEAR(_bits, i);
  }
}

- (void)calculateFromNumber:(long)fromNumber
{
  int i;
  for (i = 0; i < _nbits; i++)
  {
    if (fromNumber & (1 << i)) 
      BITSET(_bits, i);
    else
      BITCLEAR(_bits, i);
  }
}
@end