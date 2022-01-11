/**
 * Clear the console
 */
clear :- write('\33\[2J').

/**
 * Print X, N times
 */
print_n(X,0).
print_n(X, N):-N>0,
            write(X),
            N1 is N-1,
            print_n(X, N1).