#import <AEObjC/AEObjC.h>

unsigned char* pascalStringFromCString(const char* cString)
{
  unsigned char len;
  unsigned char* pString;

  if (!cString)
    return NULL;
  
  len = strlen(cString);
  pString = (unsigned char *)calloc(1, len + 1);
  pString[0] = len;
  memcpy(pString + 1, cString, len);

  return pString;
}

char* CStringFromPascalString(const unsigned char* pString)
{
    unsigned char len;
    char* cString;    

    if (!pString)
      return NULL;

    len = (size_t)pString[0];
    cString = (char *)calloc(1, len + 1);
    memcpy(cString, pString + 1, len);
    cString[len] = '\0';

    return cString;
}