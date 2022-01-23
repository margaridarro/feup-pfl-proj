:- use_module(library(lists)).
:- [display, utils, board, validation, move, win, menu, ai].

/**
* Main predicate
* Player 'O' starts by default
*/
play:-
    clear,
    menu(Board/Player, Option),
    clear,
    playGame(Board/Player, Option), 
    play.

playGame(GameState, 1):-
    playMultiplayer(GameState).
playGame(Board/_, 2):-
    playSingleplayer(Board/'O').

/**
* Multiplayer game loop
*/
playMultiplayer(Board/Player):-
    game_over(Board/Player, _),
    printReturnToMenuMessage.
playMultiplayer(Board/Player):-
    clear, 
    display_game(Board/Player), !,
    makeMove(Board/Player, NewBoard/NewPlayer),
    playMultiplayer(NewBoard/NewPlayer).    

/**
* Singleplayer game loop
* Play against the computer
*/
playSingleplayer(GameState):-
    game_over(GameState, _),
    printReturnToMenuMessage.
playSingleplayer(Board/'O'):-
    clear,
    display_game(Board/'O'), !,
    makeMove(Board/'O', NewBoard/NewPlayer),
    playSingleplayer(NewBoard/NewPlayer).
playSingleplayer(Board/'X'):-
    clear, 
    printBoard(Board), !,
    choose_move(Board/'X', 1, Move),
    move(Board/'X', Move, NewBoard/NewPlayer),
    write('\nPlayer X is thinking, press any key to hurry them up!'), read_number(_),
    playSingleplayer(NewBoard/NewPlayer).

/**
* Handle game endings: draws and wins
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