// lab1exG.c
// ENCM 369 Winter 2026 Lab 1 Exercise G

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_ABS_F (5.0e-9)
#define POLY_DEGREE 4

double polyval(const double *a, int n, double x);

/* Return a[0] + a[1] * x + ... + a[n] * pow(x, n). */
int main(void)
{
    double f[] = {1.47, 0.73, -3.03, -1.15, 1.00};
    double dfdx[POLY_DEGREE];

    double input_guess;
    int update_limit;
    int update_count;
    int n_scanned;
    int i;
    int stop_loop;

    double current_x, current_f, current_dfdx;

    printf("This program demonstrates use of Newton's Method to find\n"
           "approximate roots of the polynomial\nf(x) = ");
    printf("%.2f", f[0]);
     i = 0;
    top_loop:
    i++;
    if(i>POLY_DEGREE)goto end_loop;         
    if (f[1]>=0)goto print_true; 
    printf(" - %.2f*pow(x,%d)", -f[i], i);
    goto top_loop;
    print_true:     
    printf(" + %.2f*pow(x,%d)", f[i], i);
    goto top_loop;
    end_loop:
    printf("\nPlease enter a guess at a root, and a maximum number of\n"
           "updates to do, separated by a space.\n");
    
    
    
    n_scanned = scanf("%lf%d", &input_guess, &update_limit);
    if (n_scanned != 2)goto scan_exit;

    if (update_limit < 1)goto update_limit;
    goto good_enough;
    scan_exit:
        printf("Sorry, I couldn't understand the input.\n");
        exit(1);
    update_limit:    
        printf("Sorry, I must be allowed do at least one update.\n");
        exit(1);
    good_enough:
    printf("Running with initial guess %f.\n", input_guess);
    i = POLY_DEGREE; 
    top_loop_2:
  
    i--;
    if(i < 0)goto end_loop_2;
    dfdx[i] = (i + 1) * f[i + 1];   // Calculus!
    goto top_loop_2;
    end_loop_2:    
    current_x = input_guess;
    update_count = 0;
    stop_loop = 0;
    top_while:
        current_f = polyval(f, POLY_DEGREE, current_x);
        printf("%d update(s) done; x is %.15f; f(x) is %.15e\n",
        update_count, current_x, current_f);
        if (fabs(current_f) < MAX_ABS_F)goto top_quit;
        if (update_count == update_limit)goto middle_quit;
        current_dfdx = polyval(dfdx, POLY_DEGREE - 1, current_x);
        current_x -= current_f / current_dfdx;
        update_count++;
    goto top_while;
    top_quit:
    
    printf("Stopped with approximate solution of %.10f.\n ", 
            current_x);
    return 0;
    middle_quit:
        printf("%d updates performed, |f(x)| still >= %g.\n ", 
               update_count, MAX_ABS_F);
    return 0;
}

double polyval(const double *a, int n, double x)
{
    double result = a[n];
    int i = n;
    the_top:
    i--;
    if(i<0)goto quitter;
    result *= x;
    result += a[i];
    goto the_top;
    quitter:
    return result;
}

