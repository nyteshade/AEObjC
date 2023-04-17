#import <AEObjC/AEObjC.h>
#import <stdlib.h>
#import <string.h>

@interface AEString (Private)
- (int)AEStringCompareInternals:(AEString*)left 
                           with:(AEString*)right 
                caseInsensitive:(AEBool)caseInsensitive;
- (char *)string;
- (void)setLength:(AEULong)length;
- (void)setString:(char*)string;
@end

@implementation AEString

- (id)initWithCString:(const char*)cstring
{
  self = [super init];
  if (self)
  {
    size_t cstringLength = strlen(cstring);
    size_t charLength = sizeof(char);
    _string = calloc(1, cstringLength + charLength);
    if (_string)
    {
      strcpy(_string, cstring);
      _length = cstringLength;
    }
  }
  
  return self;
}

- (id)initWithPascalString:(unsigned char*)pstring
{
  return [self initWithCString:[AEString cStringFromPascalString:pstring]];
}

- (id)initWithAEString:(AEString*)aestring
{
  return [self initWithCString:[aestring cString]];
}

+ (id)fromCString:(const char*)cstring
{
  return [[AEString alloc] initWithCString:cstring];
}

+ (id)fromPString:(const unsigned char*)pstring
{
  return [[AEString alloc] initWithPascalString:pstring];
}

+ (id)fromAEString:(AEString*)source
{
  return [[AEString alloc] initWithAEString:source];
}


- (char*)string
{
  return _string;
}

- (void)setLength:(AEULong)length
{
  _length = length;
}

- (void)setString:(char*)string
{
  if (_string)
    free(_string);
    
  _string = string;
  _length = strlen(string);
}

- (char)charAt:(AEULong)index
{
  return (char)_string[index];  
}

- (int)compare:(AEString*)other
{
  return [self AEStringCompareInternals:self with:other caseInsensitive:NO];
}

- (int)compareInsensitive:(AEString*)other
{
  return [self AEStringCompareInternals:self with:other caseInsensitive:YES];
}

- (int)AEStringCompareInternals:(AEString*)left 
                           with:(AEString*)right 
                caseInsensitive:(AEBool)caseInsensitive
{
  if (!left && right)
    return 1;
  else if (left && !right)
    return -1;
  
  if ([left length] != [right length])
    return (int)([left length] - [right length]);
    
  if (caseInsensitive)
    return strcasecmp([left cString], [right cString]);
  else
    return strcmp([left cString], [right cString]);
}

- (AEString*)copy
{
  return [[AEString alloc] initWithAEString:self];
}

- (AEString*)concat:(AEString*)other
{
  AEString* result = nil;
  char* buffer = nil;
  size_t leftLen = strlen(_string);
  size_t rightLen = strlen(other);
  size_t charLen = sizeof(char);
  
  buffer = calloc(1, leftLen + rightLen + charLen);
  if (buffer)
  {
    strcpy(buffer, _string);
    strcat(buffer, other);
    result = [[AEString alloc] initWithCString:buffer];
    [result setLength:strlen([result string])];
    free(buffer); 
  }
  
  return result;
}

- (AEString*)substringFrom:(AEULong)start withLength:(AEULong)length
{
  AEString* result = nil;
  size_t charLen = sizeof(char);
  char* buffer = calloc(1, (charLen * length) + charLen);  
  if (buffer)
  {
    strncpy(buffer, &_string[start * charLen], length * charLen);
    result = [[AEString alloc] initWithCString:buffer];
    free(buffer);
  }
  return result;
}

- (AEString*)reverse
{
  AEString* copy = [self copy];
  unsigned long i = 0;
  unsigned long j = _length - 1;
  
  while (i < j) 
  {
    char temp = [copy string][i];
    [copy string][i] = [copy string][j];
    [copy string][j] = temp;
    i++;
    j--;
  }
  
  return copy;
}

- (AEString*)toLower
{
  AEString* lowered = [[AEString alloc] initWithCString:self];
  AEULong i = 0;
  
  for (i = 0; i < _length; i++)
  {
    [lowered string][i] = tolower([lowered string][i]);
  }  
  
  return lowered;
}

- (AEString*)toUpper
{
  AEString* uppered = [[AEString alloc] initWithCString:self];
  AEULong i = 0;
  
  for (i = 0; i < _length; i++)
  {
    [uppered string][i] = toupper([uppered string][i]);
  }  
  
  return uppered;  
}

- (AEString*)trim
{
  char *string = strdup(_string);
  char *start = string;
  char *end = &string[_length - 1];
  
  while (isspace(*start)) {
    start++;
  }
  
  while (isspace(*end)) {
    end--;
  }
  
  *(end + 1) = '\0';
  
  return [[AEString alloc] initWithCString:start];
}

- (AEString*)trimLeft
{
  char *string = strdup(_string);
  char *start = string;
  
  while (isspace(*start)) {
    start++;
  }
  
  return [[AEString alloc] initWithCString:start];
}

- (AEString*)trimRight
{
  char *string = strdup(_string);
  char *end = &string[_length - 1];
  
  while (isspace(*end)) {
    end--;
  }
  
  *(end + 1) = '\0';
  
  return [[AEString alloc] initWithCString:string];
}

/*
- (AECollection*)splitOn:(char)delimiter
{
  AECollection* collection = [[AECollection alloc] init];
  if (collection)
  {
    char* string = strdup(_string);
    char* token = strtok(string, &delimeter);
    
    while (token != NULL) {
      [collection addString:[AEString fromCString:token]];
      token = strtok(NULL, &delimiter);
    }
  }
  
  return collection;
}
*/

- (const char*)cString
{
  return _string;
}

- (unsigned char*)pascalString
{
  return [AEString pascalStringFromCString:_string];
}

- (AEULong)length
{
  return _length;
}

- (AEULong)count 
{
  return _length;
}

- (void)dealloc
{
  if (_string)
    free(_string);
  [super dealloc];
}

+ (AEBool)compareLeft:(AEString*)left 
              toRight:(AEString*)right
{
  return [left compare:right] == 0;
}

+ (AEBool)compareLeft:(AEString*)left 
              toRight:(AEString*)right
      caseInsensitive:(AEBool)caseInsensitive
{
  return [left compareInsensitive:right] == 0;
}

@end

int __NSConstantString_tag = 0;