:- [display].
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
validMove(Board/Player, Size, OldY/OldX/NewY/NewX):-
    checkInitialPos(Board/Player, Size, OldY/OldX),
    checkFinalPos(Size, OldY/OldX/NewY/NewX).

/**
* Validate Piece Choice
*/
checkInitialPos(Board/Player, Size, Y/X):-
    (checkFrame(Size, Y);checkFrame(Size, X)),
    getPosValue(Board, Y/X, Val),
    checkPlayerPermission(Player, Val).

checkPlayerPermission(Player, Val):-
    (Val == ' '; Val == Player).

/**
* Validate Piece Destination
*/
checkFinalPos(Size, OldY/OldX/NewY/NewX):-
    checkValidPos(OldY/OldX/NewY/NewX, Size),
    checkNotSamePos(OldY/OldX/NewY/NewX),
    (checkFrame(Size, NewY);checkFrame(Size, NewX)).

checkNotSamePos(OldY/OldX/NewY/NewX):-
    NewY \= OldY; NewX \= OldX.

checkValidPos(Y/OldX/Y/NewX, Size):-
    checkFrame(Size, NewX).
checkValidPos(OldY/X/NewY/X, Size):-
    checkFrame(Size, NewY).

checkFrame(_, 0).
checkFrame(Size, Size).

getPosValue(Board, Y/X, Val):-
    nth0(Y, Board, Line),
    nth0(X, Line, Val).


/**
* Move Input Validation
*/
readMove(Size, OldY/OldX/NewY/NewX):-
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

