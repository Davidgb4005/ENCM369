// globals1B.c
// ENCM 369 Winter 2026 Exercise B

void copy(int *to, const int *from, int n)
{
  int i;
  for (i = 0; i < n; i++)
    to[i] = from[i];

  // point one (which is AFTER the loop is finished)

  return;
}


void reverse(int *dest, const int *src, int n)
{
  const int *guard;
  int k = n - 1;
  guard = src + n;
  while (src != guard) {
    dest[k] = *src;
    src++;

    // point two

    k--;
  }

  // point three
}

int aa[5];
int bb[] = {101, 123, 145, 167, 189};
int cc = 600;

void update_cc(int z)
{
  cc += z;
}

int main(void)
{
  int dd[6];
  int ee[5] = {505, 404, 303, 202, 101};

  update_cc(30);
  copy(dd, bb, 5);
  update_cc(200);
  reverse(aa, ee, 5);
  update_cc(5);
  return 0;
}
