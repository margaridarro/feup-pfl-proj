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
    resetBoard([], 5, Board),
    playGame('O', Board),
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


playerHandler('O', NewPlayer):-
    NewPlayer = 'X'.
playerHandler('X', NewPlayer):-
    NewPlayer = 'O'.



/*
playTestWin:-
    playGame('O', [[' ',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], playing).
    
moveTest(Player, Board):-
    move(Player, Board, NewBoard),
    printBoard(NewBoard).

% moveTest('O', [[' ',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']]).

*/