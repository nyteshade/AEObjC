#ifndef AE_TYPES_H
#define AE_TYPES_H

typedef unsigned char AEByte;
typedef unsigned char AEBool;
typedef unsigned long AEULong;
typedef unsigned char *AEUStrPtr;
typedef unsigned long AEUInteger;
typedef double AEDecimal;
typedef long AEInteger;
typedef long AELong;
typedef void *AEPointer;
typedef char *AEStrPtr;

extern const AEBool AETrue;
extern const AEBool AEFalse;

/**
 * @brief Used by collection map() style methods where data transforms occur
 * to collection items. When items should be kept without any change to the
 * data, use AE_IGNORE. When items should be removed from the resulting
 * collection, use AE_DROP. Lastly, when changes were made, return
 * AE_TRANSFORM.
 */
typedef enum AEDataMapDecision {
  AE_IGNORE,
  AE_DROP,
  AE_TRANSFORM
} AEDataMapDecision;

#endif
