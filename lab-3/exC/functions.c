/* functions.c: ENCM 369 Winter 2026 Lab 3 Exercise C */

/* INSTRUCTIONS:
 *   You are to write a RARS translation of this C program.  Because
 *   this is the first assembly language program you are writing where you
 *   must deal with register conflicts and manage the stack, there are
 *   a lot of hints given in C comments about how to do the translation.
 *   In future lab exercises and on midterms, you will be expected
 *   to do this kind of translation without being given very many hints!
 */

/* Hint: Function prototypes, such as the next two lines of C,
 * are used by a C compiler to do type checking and sometimes type
 * conversions in function calls.  They do NOT cause ANY assembly
 * language code to be generated.
 */
  /* Hint: This is a nonleaf function, so it needs a stack frame. */

  /* Instruction: Normally you could pick whatever two s-registers you
   * like for banana and apple, but in this exercise you must use s0
   * for apple and s1 for banana.
   */

  /* Hint: This is a nonleaf function, so it needs a stack frame,
   * and you will have to make copies of the incoming arguments so
   * that a-registers are free for outgoing arguments. */

  /* Instructions: Normally you would have a lot of freedom within the
   * calling conventions about what s-registers you use, and about where
   * you put copies of incoming arguments, but in this exercise you
   * must copy first to s0, second to s1, third to s2, and fourth to s3, 
   * and use s4 for bus, s5 for car, and s6 for truck.
   */

  /* Hint: this is a leaf function, and it shouldn't need to use any
   * s-registers, so you should not have use the stack at all. */
int funcA(int first, int second, int third, int fourth);

int funcB(int y, int z);

int orange = 0x30000;

int main(void)
{

  int apple;
  int banana;
  banana = 0x500;
  apple = 0x700;
  apple += funcA(2, 4, 3, 5);
  orange += (banana - apple);

  /* At this point orange should have a value of 0x2fb74. */

  return 0;
}

int funcA(int first, int second, int third, int fourth)
{

  int bus;
  int car;
  int truck;
  car = funcB(third, fourth);
  bus = funcB(second, first);
  truck = funcB(fourth, third);

  return bus + car + truck;
}

int funcB(int y, int z)
{
  return y + z * 64;
}
