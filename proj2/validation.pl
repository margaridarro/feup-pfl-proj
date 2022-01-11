/*
checkMove()
    checkFramePos,
    checkPlayerPermission(),
    checkFinalPos() % same col or line
*/  

/**
* Validate Piece Choice
*/
checkPlayerPermission(Player, Board, PosX, PosY):-
    nth0(PosY, Board, Line),
    nth0(PosX, Line, Elem),
    (Elem == ' '; Elem == Player).

/**
* Validate Piece Destination
*/
checkFinalPos(OldX, OldY, NewX, NewY):-
    checkNotSamePos(OldX, OldY, NewX, NewY),
    checkFramePos(NewX, NewY), 
    checkValidPos(OldX, OldY, NewX, NewY).

checkNotSamePos(OldX, OldY, NewX, NewY):-
    NewX =\= OldX; NewY =\= OldY.

checkFramePos(PosX, PosY):-
    PosX == 0; PosX == 4; 
    PosY == 0; PosY == 4.

checkValidPos(OldX, OldY, NewX, NewY):-
    NewX == OldX; NewY == OldXY.

