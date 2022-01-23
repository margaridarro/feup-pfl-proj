:- use_module(library(random)).

/**
* Initial Menu
* Manage player options
    * 1. Multiplayer
    * 2. Singleplayer 
*/
menu(Board/Player, Option):-
    printMenu,
    readMenuOption(Option),
    prepareGame(Board/Player). 

/**
* Option 1: Multiplayer 
* Option 2: Singleplayer
*/
prepareGame(Board/Player):-
    readBoardSize(Size),
    initial_state(Size, Board/Player).
    
initial_state(Size, Board/Player):-    
    resetBoard([], Size, Size, Board),
    Players = ['O', 'X'],
    random_member(Player, Players).