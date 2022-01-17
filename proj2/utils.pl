/**
 * Clear the console
 */
clear :- write('\33\[2J').

/**
 * Print X, N times
 */
print_n(_,0).
print_n(X, N):-
    N>0,
        write(X),
        N1 is N-1,
        print_n(X, N1).

/**
clean board
[[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ']]
printBoard([[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ']])

board filled with 'O' in second column
[[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']]

*/


/**
* Read number
*/
read_number(X):-
    read_num(X,0).

read_num(X,X):- 
    peek_code(10), !, skip_line.
read_num(X,T):- 
    get_code(D),
    char_code('0', Z),
    Num is D-Z,
    Num >= 0, Num =< 9, !, 
    Next is T*10+Num,
    read_num(X, Next).
read_num(X,T):-read_num(X, T).





/**
* Read letter
*/
/*
read_letter(X):-
    read_let(X,0).

read_let(X,X):- 
    peek_code(10), !, skip_line.
read_let(X,T):- 
    get_code(D),
    char_code('a', Z),
    write(D),
    nl,
    Num is D-Z,
    Num >= 0, Num =< 4, !,
    atom_concat(T, Z, Next),
    read_num(D, Next),
    X is D.
read_let(X,T):-read_let(X, T).
*/