:- use_module(library(lists)).

:- [display, utils, board, validation, move, win].
:- [test].

/**
* main
*/
play:-
    clear,
    menu(Board),
    clear,
    playGame('O', Board, playing), %initialplayer
    play.

playGame(_, Board, end):-
    printBoard(Board),
    write('Press any key to return to menu'),
    read_number(_).
playGame(Player, Board, playing):-
    printBoard(Board),
    move(Player, Board, NewBoard),
    playerHandler(Player, NewPlayer),
    updateState(NewBoard, playing, NewState),
    playGame(NewPlayer, NewBoard, NewState).


/**
* Initial Menu
* Manage player options
    * 1. Multiplayer - Quick Start
    * 2. Multiplayer - Custom Board Size
*/
menu(Board):-
    printWelcomeMessage,
    readMenuOption(Option),
    chooseMenuOption(Option, Board). 

/**
* Option 1: Multiplayer (default 5x5)
* Option 2: Custom Board Size
*/
chooseMenuOption(1, Board):-
    resetBoard([], 5, 5, Board).
chooseMenuOption(2, Board):-
    readBoardSize(BoardSize),
    resetBoard([], BoardSize, BoardSize, Board).
    

/**
* Alternate between players
*/
playerHandler('O', NewPlayer):-
    NewPlayer = 'X'.
playerHandler('X', NewPlayer):-
    NewPlayer = 'O'.


updateState(Board, _, NewState):-
    length(Board, Size),
    draw(Board, Size),
    NewState = end,
    printDrawMessage.
updateState(Board, _, NewState):-
    length(Board, Size),
    win(Board, Size, Winner),
    printWinMessage(Winner),
    NewState = end.
updateState(_, State, NewState):-
    NewState = State.

/*
Invalid Win:
win([[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ']], Winner).
*/
