/**
* Menu Input Validation
*/
readMenuOption(Option):-
    write('Option: '), read_number(Option),
    validateMenuOption(Option).
readMenuOption(_):- 
    write('Invalid option, choose a number between 1 and 2.\n'),
    readMenuOption(_).

validateMenuOption(Option):-
    Option == 1;
    Option == 2.

/**
* Board Size Input Validation 
*/
readBoardSize(Size):-
    write('Size: '), read_number(Size),
    validateBoardSize(Size).
readBoardSize(_):-
    write('Invalid option, choose a number between 2 and 10.\n'),
    readBoardSize(_).

validateBoardSize(Size):-
    Size >= 2, Size =< 10.


/**
* Move Validation
*/
checkMove(Player, Board, OldY/OldX, NewY/NewX):-
    checkInitialPos(Player, Board, OldY/OldX),
    checkFinalPos(OldY/OldX, NewY/NewX).
/*
Invalid Move:
checkMove('X', [['O','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/5, 0/9).
Valid Moves:
checkMove('O', [['O','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/5, 0/9).
checkMove('O', [['O',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/6, 4/6).
*/

/**
* Validate Piece Choice
*/
checkInitialPos(Player, Board, Y/X):-
    checkFramePos(Y/X),
    getPosValue(Board, Y/X, Val),
    checkPlayerPermission(Player, Val).

checkPlayerPermission(Player, Val):-
    (Val == ' '; Val == Player).

/**
* Validate Piece Destination
*/
checkFinalPos(OldY/OldX, NewY/NewX):-
    checkNotSamePos(OldY/OldX, NewY/NewX),
    checkFramePos(NewY/NewX), 
    checkValidPos(OldY/OldX, NewY/NewX).

checkNotSamePos(OldY/OldX, NewY/NewX):-
    NewY \== OldY; NewX \== OldX.

checkValidPos(OldY/OldX, NewY/NewX):-
    NewY == OldY; NewX == OldX.


/**
* Move Input Validation
*/
readMove(OldY/OldX, NewY/NewX):-
    write('First, tell me the piece you would like to move.\n'),
    readY(OldY), 
    readX(OldX),
    nl,
    write('Now, tell me the place where you would like insert the piece.\n'),
    readY(NewY),
    readX(NewX).
    
readY(Y):-
    write('Line: '), read_number(Y),
    Y >= 0,
    Y =< 4, !.
readY(Y):-
    write('Invalid Input for Line, choose a number between 0 and 4\n'),
    readY(Y).

readX(X):-
    write('Column: '), read_number(X),
    X >= 5,
    X =< 9, !.
readX(X):-
    write('Invalid Input for Column, choose a number between 5 and 9\n'),
    readX(X).

/**
* General Validation
*/
checkFramePos(Y/X):-
    Y == 0; Y == 4; 
    X == 5; X == 9.

getPosValue(Board, Y/X, Val):-
    X1 is X - 5,
    nth0(Y, Board, Line),
    nth0(X1, Line, Val).