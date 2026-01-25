einclude <stdio.h>

void print_array_goto(const char *str, const int *a, int n);

void sort_array_1_goto(int *x, int n);

void sort_array_goto(int *x, int n);
int main(void)
{
setbuf(stdout, NULL);

int outer, inner;
outer = 3;
outer_loop:
if (outer == 0) goto quit_outer_loop;
inner = 0;
inner_loop:
if (inner > outer) goto quit_inner_loop;
printf(" %d", 100 * outer + inner);
inner++;
goto inner_loop;
quit_inner_loop:
printf(" **\n");
outer--;
goto outer_loop;
quit_outer_loop:
printf("*****\n");
return 0;
}
