:- use_module(library(clpfd)).

/**
* Reset Board
*/
resetBoard(Board, 0, _, FinalBoard):- FinalBoard = Board.
resetBoard(Board, L, C, FinalBoard):-
    L > 0,
        L1 is L-1,
        addBoardLine(Board, C, NewBoard),
        resetBoard(NewBoard, L1, C, FinalBoard).

addBoardLine(Board, C, NewBoard):-
    addLineElem([], C, NewLine),
    NewLine1 = [NewLine],
    append(Board, NewLine1, NewBoard).

/*
* Add new line to board
*/
addLineElem(Line, 0, FinalLine):- FinalLine = Line.
addLineElem(Line, C, FinalLine):-
    C > 0, 
        C1 is C-1,
        addElem(Line, NewLine),
        addLineElem(NewLine, C1, FinalLine).

/**
* Add new piece to line
*/
addElem(Line, NewLine):-
    append(Line, [' '], NewLine).

/**
* Change a board line
*/
changeBoardLine(Board, Size, _, _, NewBoard, NewBoard):-
    length(Board, Length),
    Size == Length.
changeBoardLine(Board, N, N, NewLine, NewBoard, FinalBoard):-
    Line = [NewLine],
    append(NewBoard, Line, NewBoard1),
    N1 is N+1,
    changeBoardLine(Board, N1, N, NewLine, NewBoard1, FinalBoard).
changeBoardLine(Board, N, Y, NewLine, NewBoard, FinalBoard):-
    nth0(N, Board, Line1),
    Line = [Line1],
    append(NewBoard, Line, NewBoard1),
    N1 is N+1,
    changeBoardLine(Board, N1, Y, NewLine, NewBoard1, FinalBoard).


/**
* Move Piece in Line
*/
shiftLine(Line, OldX, 0, Value, NewLine):-
    newShiftLineLeft(Line, OldX, Value, NewLine).
shiftLine(Line, OldX, 1, Value, NewLine):-
    newShiftLineRight(Line, OldX, Value, NewLine).

newShiftLineLeft(Line, OldX, Value, FinalLine):-
    ValueList = [Value],
    nth0(OldX, Line, _, NewLine),
    append(NewLine, ValueList, FinalLine). 

newShiftLineRight(Line, OldX, Value, NewLine):-
    length(Line, L), 
    OldX1 is L-1-OldX,
    reverse(Line, ReverseLine),
    newShiftLineLeft(ReverseLine, OldX1, Value, NewReverseLine),
    reverse(NewReverseLine, NewLine).


/**
* Move Piece in Line
* Change Line in Board
* Way is 0 if shiftLineLeft
* Way is 1 if shiftLineRight 
*/
changeLine(Board, Y, OldX, Value, Way, NewBoard):-
    nth0(Y, Board, Line),
    shiftLine(Line, OldX, Way, Value, NewLine), 
    changeBoardLine(Board, 0, Y, NewLine, [], NewBoard).


/**
* Move Piece in Column
* Change Column in Board
* Way is 0 if shiftColUp
* Way is 1 if shiftColDown 
*/
changeCol(Board, X, OldY, Value, Way, NewBoard):-
    transpose(Board, TransposeBoard),
    nth0(X, TransposeBoard, Col),
    shiftLine(Col, OldY, Way, Value, NewCol), 
    changeBoardLine(TransposeBoard, 0, X, NewCol, [], FinalTransposeBoard),
    transpose(FinalTransposeBoard, NewBoard).



