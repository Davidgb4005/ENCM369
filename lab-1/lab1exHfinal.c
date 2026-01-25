// lab2exH.c
// ENCM 369 Winter 2026 Lab 1 Exercise H

#include <stdio.h>

void print_array(const char *str, const int *a, int n);
void sort_array(int *x, int n);

int main(void)
{

  int test_array[] = {4000,5000,7000,1000,3000,4000,2000,6000};
  print_array("before sorting with goto...", test_array,8);
  sort_array(test_array, 8);
  print_array("after sortin with goto...", test_array, 8);
}
void print_array(const char *str, const int *a, int n)
{
  int i = 0;
  puts(str);
start_cond:
  if (i < n)goto true_cond;
  printf("\n");
  return;
true_cond:
  printf("    %d", a[i]);
  i++;
  goto start_cond;
}

void sort_array(int *x, int n)
{
  // This is an implementation of an algorithm called insertion sort.

  int outer =0, inner=0, vti = x[1];
  
  outer_iter:
  x[inner + 1] = vti;
  outer++;

  if (outer>=n)return;
  vti = x[outer];
  inner = outer -1;

  inner_iter:
  if (inner<0)goto outer_iter;
  if (x[inner] <= vti)goto outer_iter;  
  x[inner + 1] = x[inner];
  inner--;
  goto inner_iter;
} 

