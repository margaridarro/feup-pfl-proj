:- use_module(library(lists)).

:- [display, utils, board, validation, move, win].

createBoard(Board):-
    resetBoard([], 5, Board),
    printBoard(Board).
/*
stateManager(State):-
    initialState.
*/

play:-
    clear,
    menu,
    playGame('O', Board, playing). %initialplayer
    play.

playGame(Player, Board, end):-
    printBoard(Board),
    printPlayerTurnMessage(Player).
playGame(Player, Board, playing):-
    printBoard(Board),
    move(Player, Board, NewBoard),
    printBoard(NewBoard),
    playerHandler(Player, NewPlayer),
    updateState(Board, playing, NewState),
    playGame(NewPlayer, NewBoard, NewState).


/**
* Initial Menu
* Manage player options
    * 1. Multiplayer - Quick Start
    * 2. Multiplayer - Custom Board Size
*/
menu(Option):-
    printWelcomeMessage,
    readMenuOption(Option),
    chooseMenuOption(Option, Board).
/**
* Option 1: Multiplayer (default 5x5?)
* Option 2: Custom Board Size
*/
chooseMenuOption(1, Board):-
    resetBoard([], 5, Board).
chooseMenuOption(2, Board):-
    chooseBoardSize(BoardSize),
    resetBoard([], BoardSize, Board).


playerHandler('O', NewPlayer):-
    NewPlayer = 'X'.
playerHandler('X', NewPlayer):-
    NewPlayer = 'O'.


updateState(Board, _, NewState):-
    draw(Board),
    NewState = end,
    printDrawMessage.
updateState(Board, _, NewState):-
    win(Board, Winner),
    printWinMessage(Winner),
    NewState = end.
updateState(_, State, NewState):-
    NewState = State.


/*
playTestWin:-
    playGame('O', [[' ',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], playing).
    
moveTest(Player, Board):-
    move(Player, Board, NewBoard),
    printBoard(NewBoard).

% moveTest('O', [[' ',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']]).

*/