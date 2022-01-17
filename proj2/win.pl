:- use_module(library(clpfd)).

win(Board, Winner):-
    completeLine(Board, Winner);
    completeColumn(Board, Winner);
    completeDiagonals(Board, Winner).
/*
printBoard([['X',' ',' ',' ',' '],[' ','X',' ',' ',' '],[' ',' ','X',' ',' '],[' ',' ',' ','X',' '],[' ',' ',' ',' ','X']]).
Complete Diagonal:
[['X',' ',' ',' ',' '],[' ','X',' ',' ',' '],[' ',' ','X',' ',' '],[' ',' ',' ','X',' '],[' ',' ',' ',' ','X']]
*/

draw(Board):-
    (
        completeLine(Board, 'O'), 
        completeLine(Board, 'X') 
    );
    (
        completeColumn(Board, 'O'), 
        completeColumn(Board, 'X')
    ).
/*
Valid Draw:
draw([['X','X','X','X','X'],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],['O','O','O','O','O']]).
*/

completeDiagonals(Board, Winner):-
    completeDiagonal1(Board, 0, Winner);
    completeDiagonal2(Board, 0, Winner).

completeDiagonal1(Board, 0, Winner):-
    nth0(0, Board, Line),
    nth0(0, Line, Value),
    Winner = Value,
    completeDiagonal1(Board, 1, Winner).
completeDiagonal1(Board, 4, Winner):-
    nth0(N, Board, Line),
    nth0(N, Line, Value),
    Winner == Value.
completeDiagonal1(Board, N, Winner):-
    nth0(N, Board, Line),
    nth0(N, Line, Value),
    Winner == Value,
    N1 is N+1,
    completeDiagonal1(Board, N1, Winner).
/*
Valid Complete Diagonal1:
completeDiagonal1([['X',' ',' ',' ',' '],[' ','X',' ',' ',' '],[' ',' ','X',' ',' '],[' ',' ',' ','X',' '],[' ',' ',' ',' ','X']], 0, 'X').
*/

completeDiagonal2(Board, 0, Winner):-
    nth0(0, Board, Line),
    nth0(4, Line, Value),
    Winner = Value,
    completeDiagonal2(Board, 1, Winner).
completeDiagonal2(Board, 4, Winner):-
    nth0(N, Board, Line),
    Idx is 4 - N,
    nth0(Idx, Line, Value),
    Winner == Value.
completeDiagonal2(Board, N, Winner):-
    nth0(N, Board, Line),
    Idx is 4 - N,
    nth0(Idx, Line, Value),
    Winner == Value,
    N1 is N+1,
    completeDiagonal2(Board, N1, Winner).
/*
Valid Complete Diagonal2:
completeDiagonal2([['X',' ',' ',' ','O'],[' ','X',' ','O',' '],[' ',' ','O',' ',' '],[' ','O',' ','X',' '],['O',' ',' ',' ','X']], 0, Player).
*/



/**
* Verify if any board line is complete
*/
completeLine(Board, Player):-
    verifyLines(Board, 0, Player).
/*
Complete Line:
completeLine([['X','X','X','X','X'],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], Player).
*/


/**
* Verify if any board column is complete
*/
completeColumn(Board, Player):-
    transpose(Board, TransposeBoard),
    verifyLines(TransposeBoard, 0, Player).
/*
Complete Column:
completeColumn([['X','O','X','X','X'],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], Player).

Incomplete Column:
completeColumn([['X','O','X','X','X'],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 'X').
*/


/**
* Iterate lines
* Verify each line 
*/
verifyLines(_, 5, _):- !, false.
verifyLines(Board, N, Player):-
    nth0(N, Board, Line),
    verifyLine(Line, Player).
verifyLines(Board, N, Player):-
    N1 is N+1,
    verifyLines(Board, N1, Player).
/**
* Check if Player completed a line
*/
verifyLine(Line, _):-
    member(' ', Line), !, false.
verifyLine(Line, Player):-
    \+ member('X', Line),
    Player = 'O'.
verifyLine(Line, Player):-
    \+ member('O', Line),
    Player = 'X'.
