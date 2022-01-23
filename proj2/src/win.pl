:- use_module(library(clpfd)).

/**
* Verify if any player has won the game
*/
win(Board, Size, Winner):-
    completeLine(Board, Size, Winner);
    completeColumn(Board, Size, Winner);
    completeDiagonals(Board, Size, Winner).


/**
* Verify if a draw has happened
*/
draw(Board, Size):-
    (
        completeLine(Board, Size, 'O'), 
        completeLine(Board, Size, 'X') 
    );
    (
        completeColumn(Board, Size, 'O'), 
        completeColumn(Board, Size, 'X')
    ).


/**
* Verify if any diagonal have been completed by any player
*/
completeDiagonals(Board, Size, Winner):-
    Size1 is Size-1,
    ( completeDiagonal1(Board, 0, Size1, 'X'); 
      completeDiagonal2(Board, 0, Size1, 'X') ),
        Winner = 'X'.
completeDiagonals(Board, Size, Winner):-
    Size1 is Size-1,
    ( completeDiagonal1(Board, 0, Size1, 'O');
      completeDiagonal2(Board, 0, Size1, 'O') ),
        Winner = 'O'.

/**
* Verify if the first diagonal have been completed by a player
*/
completeDiagonal1(Board, Size, Size, Winner):-
    nth0(Size, Board, Line),
    nth0(Size, Line, Value),
    Winner == Value.
completeDiagonal1(Board, N, Size, Winner):-
    nth0(N, Board, Line),
    nth0(N, Line, Value),
    Winner == Value,
    N1 is N+1,
    completeDiagonal1(Board, N1, Size, Winner).


/**
* Verify if the second diagonal have been completed by a player
*/
completeDiagonal2(Board, N, 0, Winner):-
    nth0(N, Board, Line),
    nth0(0, Line, Value),
    Winner == Value.
completeDiagonal2(Board, N, Size, Winner):-
    nth0(N, Board, Line),
    nth0(Size, Line, Value),
    Winner == Value,
    N1 is N+1, Size1 is Size-1,
    completeDiagonal2(Board, N1, Size1, Winner).

/**
* Verify if any board line is complete
*/
completeLine(Board, Size, Player):-
    verifyLines(Board, 0, Size, Player).


/**
* Verify if any board column is complete
*/
completeColumn(Board, Size, Player):-
    transpose(Board, TransposeBoard),
    verifyLines(TransposeBoard, 0, Size, Player).


/**
* Iterate lines
* Verify if each line is complete
*/
verifyLines(_, Size, Size,_):- !, false.
verifyLines(Board, N, _, Player):-
    nth0(N, Board, Line),
    verifyLine(Line, Player).
verifyLines(Board, N, Size, Player):-
    N1 is N+1,
    verifyLines(Board, N1, Size, Player).
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
