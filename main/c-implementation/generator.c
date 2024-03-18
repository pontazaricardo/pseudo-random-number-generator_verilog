#include <stdio.h>

unsigned int middlesquare_generator(unsigned int seed);
unsigned int xorshifter_generator(unsigned int seed);

unsigned int middlesquare_generator(unsigned int seed)
{

   unsigned int middlePart01 = seed >> 8;
   unsigned int middle = middlePart01 & 65535;

   unsigned int generatedRandom = middle*middle;

   return generatedRandom;

}

unsigned int xorshifter_generator(unsigned int seed)
{
   
   unsigned int step01 = seed ^ seed >> 7;
   unsigned int step02 = step01 ^ step01 << 9;
   unsigned int generatedRandom = step02 ^ step02 >> 13;

   return generatedRandom;

}

int main() {

   printf("=== Pseudo-random number generator ===\n");
   printf("1. Middle-square method: Generates a list of 1000 numbers and prints a list (test.txt).\n");
   
   unsigned int originalSeed = 20240301;
   unsigned int random = 0;

   // Algorithm 1: Middle-square Method

   FILE *fp01;
   fp01 = fopen("test.txt", "w");

   random = middlesquare_generator(originalSeed);

   for(int i=0;i<1000;i++){
      //printf("%d, %u, ",i,random);

      unsigned int l = sizeof(random) * 8;
      for (int i = l - 1 ; i >= 0; i--) {

         unsigned int digitToPrint = (random & (1 << i)) >> i;

         //printf("%u", digitToPrint);
         fprintf(fp01, "%u", digitToPrint);
      }

      //printf("\n");
      fprintf(fp01, "\n");

      random = middlesquare_generator(random);
   }

   fclose(fp01);
   printf("- Done!\n\n");

   // Algorithm 2: XOR-shift Method (linear-feedback shift register)
   
   printf("2. XOR-Shifter method: Generates a list of 1000 numbers and prints a list (test02.txt).\n");

   FILE *fp02;
   fp02 = fopen("test02.txt", "w");

   random = xorshifter_generator(originalSeed);

   for(int i=0;i<1000;i++){
      //printf("%d, %u, ",i,random);

      unsigned int l = sizeof(random) * 8;
      for (int i = l - 1 ; i >= 0; i--) {

         unsigned int digitToPrint = (random & (1 << i)) >> i;

         //printf("%u", digitToPrint);
         fprintf(fp02, "%u", digitToPrint);
      }

      //printf("\n");
      fprintf(fp02, "\n");

      random = xorshifter_generator(random);
   }

   fclose(fp02);
   printf("- Done!\n");

   return 0;
}