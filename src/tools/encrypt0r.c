/* Encrypts a flat binary with
 * an XOR key. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define XOR_KEY  '\x35'
#define CONSTANT 16

int main(int argc, char** argv){
  uint8_t data[512];
  FILE* fp = fopen(argv[1], "rb");
  if(!fp){
    fprintf(stderr, "[-] can't open file.\n");
    return 1;
  }
  fread(data, sizeof(data), 1, fp);
  fclose(fp);

  for(size_t i = 0; i != 512; i++){
    printf("0x%x, ", data[i] ^ XOR_KEY);
    if(i % CONSTANT == 0) printf("\n");
  }  
  return 0;
}