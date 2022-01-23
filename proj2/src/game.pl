:- use_module(library(lists)).
:- [display, utils, board, validation, move, win, menu, ai].

/**
* Main predicate
* Player 'O' starts by default
*/
play:-
    clear,
    menu(Board/Player, Mode),
    clear,
    playGame(Board/Player, Mode), 
    play.

/**
* Game loop
* Mode depends on menu option - Multiplayer or Singleplayer
*/
playGame(Board/Player, _):-
    game_over(Board/Player, _),
    printReturnToMenuMessage.
playGame(Board/Player, Mode):-
    clear, 
    modeMove(Board/Player, NewBoard/NewPlayer, Mode),
    playGame(NewBoard/NewPlayer, Mode).    

modeMove(Board/Player, NewBoard/NewPlayer, Mode):-
    (Mode == 1; Player == 'O'),
    display_game(Board/Player), !,
    makeMove(Board/Player, NewBoard/NewPlayer).
modeMove(Board/Player, NewBoard/NewPlayer, 2):-
    printBoard(Board), !,
    choose_move(Board/'X', 1, Move),
    move(Board/'X', Move, NewBoard/NewPlayer),
    printPcPlayingMessage.

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
    printPcPlayingMessage,
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