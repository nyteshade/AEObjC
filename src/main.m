#import <stdio.h>
#import <AEObjC/AEObjC.h>

int main()
{
  AEString* hello = @"Hello Amiga";
  printf("AEString: %s\n", [hello cString]);
  
  return 0;
}