/**
* Menu Input Validation
*/
readMenuOption(Option):-
    write('Option: '), read_number(Option),
    validateMenuOption(Option).
readMenuOption(Option):- 
    write('Invalid option, choose a number between 1 and 2.\n'),
    readMenuOption(Option).

validateMenuOption(Option):-
    Option == 1;
    Option == 2.

/**
* Board Size Input Validation 
*/
readBoardSize(Size):-
    write('Board Size: '), read_number(Size),
    Size >= 2, Size =< 10.
readBoardSize(Size):-
    write('Invalid size, choose a number between 2 and 10.\n'),
    readBoardSize(Size).

/**
* Move Validation
*/
checkMove(Player, Board, Size, OldY/OldX, NewY/NewX):-
    checkInitialPos(Player, Board, Size, OldY/OldX),
    checkFinalPos(Size, OldY/OldX, NewY/NewX).
/*
Invalid Move:
checkMove('X', [['O','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 5, 0/5, 0/9).
Valid Moves:
checkMove('O', [['O','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 5, 0/5, 0/9).
checkMove('O', [['O',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 5, 0/6, 4/6).
*/

/**
* Validate Piece Choice
*/
checkInitialPos(Player, Board, Size, Y/X):-
    checkFramePos(Size, Y/X),
    getPosValue(Board, Y/X, Val),
    checkPlayerPermission(Player, Val).

checkPlayerPermission(Player, Val):-
    (Val == ' '; Val == Player).

/**
* Validate Piece Destination
*/
checkFinalPos(Size, OldY/OldX, NewY/NewX):-
    checkNotSamePos(OldY/OldX, NewY/NewX),
    checkFramePos(Size, NewY/NewX), 
    checkValidPos(OldY/OldX, NewY/NewX).

checkNotSamePos(OldY/OldX, NewY/NewX):-
    NewY \== OldY; NewX \== OldX.

checkValidPos(OldY/OldX, NewY/NewX):-
    NewY == OldY; NewX == OldX.


/**
* Move Input Validation
*/
readMove(Size, OldY/OldX, NewY/NewX):-
    write('First, tell me the piece you would like to move.\n'),
    readY(Size, OldY), 
    readX(Size, OldX),
    nl,
    write('Now, tell me the place where you would like insert the piece.\n'),
    readY(Size, NewY),
    readX(Size, NewX).
    
readY(Size, Y):-
    write('Line: '), read_number(Y),
    Y >= 1,
    Y =< Size, !.
readY(Size, Y):-
    write('Invalid Input for Line, choose a number between 1 and '), 
    write(Size), nl,
    readY(Size, Y).
    

readX(Size, X):-
    write('Column: '), read_number(X),
    X >= 1,
    X =< Size, !.
readX(Size, X):-
    write('Invalid Input for Column, choose a number between 1 and '),
    write(Size), nl,
    readX(Size, X).

/**
* General Validation
*/
checkFramePos(Size, Y/X):-
    Y == 1; Y == Size; 
    X == 1; X == Size.

getPosValue(Board, Y/X, Val):-
    nth1(Y, Board, Line),
    nth1(X, Line, Val).