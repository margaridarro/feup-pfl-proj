:- use_module(library(lists)).

:- [display, utils, board, validation].

/*
paste: ctrl+shift+insert
copy: ctrl+insert
*/

createBoard(Board):-
    resetBoard([], 5, Board),
    printBoard(Board).

play(X):-
    resetBoard([], 5, Board),
    printBoard(Board),
    runGame(Board, X).
    /*
    restartGame(X), 
    play(X).
    */

restartGame(X).    

runGame(Board, X).



%move(Val, Line1, Col1, Line2, Col2):-
    %checkMove






