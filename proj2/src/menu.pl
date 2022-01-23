:- use_module(library(random)).

/**
* Initial Menu
* Manage player options
    * 1. Multiplayer - Quick Start
    * 2. Multiplayer - Custom Board Size
*/
menu(Board/Player):-
    printMenu,
    readMenuOption(Option),
    chooseMenuOption(Option, Board/Player). 

/**
* Option 1: Multiplayer (default 5x5)
* Option 2: Custom Board Size
*/
chooseMenuOption(1, Board/Player):-
    initial_state(5, Board/Player).
chooseMenuOption(2, Board/Player):-
    readBoardSize(Size),
    initial_state(Size, Board/Player).
    
initial_state(Size, Board/Player):-    
    resetBoard([], Size, Size, Board),
    Players = ['O', 'X'],
    random_member(Player, Players).