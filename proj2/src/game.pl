:- use_module(library(lists)).

:- [display, utils, board, validation, move, win, menu, ai].

/**
* main
* player 'O' starts by default
*/
play:-
    clear,
    menu(Board/Player),
    clear,
    playGame(Board/Player), 
    play.

playGame(Board/Player):-
    game_over(Board/Player, Winner),
    printReturnToMenuMessage.
playGame(Board/Player):-
    display_game(Board/Player), !,
    makeMove(Board/Player, NewBoard/NewPlayer),
    playGame(NewBoard/NewPlayer).    

/**
* State Handler
    * playing
    * end
*/
game_over(Board/_, Winner):-
    length(Board, Size),
    draw(Board, Size),
    Winner = both,
    printDrawMessage.
game_over(Board/_, Winner):-
    length(Board, Size),
    win(Board, Size, Winner),
    clear,
    printBoard(Board),
    printWinMessage(Winner).
game_over(_/_, _):-
    false.