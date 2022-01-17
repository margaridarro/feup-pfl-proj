:- use_module(library(clpfd)).

/**
* Reset Board
*/
resetBoard(Board, 0, FinalBoard):- FinalBoard = Board.
resetBoard(Board, N, FinalBoard):-
    N > 0,
        N1 is N-1,
        addBoardLine(Board, NewBoard),
        resetBoard(NewBoard, N1, FinalBoard).

addBoardLine(Board, NewBoard):-
    append(Board, [[' ', ' ', ' ', ' ', ' ']], NewBoard).

/**
* Change Line in Board
*/
changeBoardLine(_,5,_,_,NewBoard, FinalBoard):- FinalBoard = NewBoard.
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
/*
changeBoardLine([[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0, 1, [' ',' ','X',' ',' '], [], FinalBoard).
*/

/**
* Move Piece in Line
*/
shiftLine(Line, 0, Value, NewLine):-
    shiftLineLeft(Line, Value, NewLine).
shiftLine(Line, 1, Value, NewLine):-
    shiftLineRight(Line, Value, NewLine).

shiftLineLeft([_|Tail], Value, NewLine):-
     ValueList = [Value],
     append(Tail, ValueList, NewLine).

shiftLineRight(Line, Value, NewLine):-
    reverse(Line, ReverseLine),
    shiftLineLeft(ReverseLine, Value, NewReverseLine),
    reverse(NewReverseLine, NewLine).

/**
* Move Piece in Line
* Change Line in Board
* Way is 0 if shiftLineLeft
* Way is 1 if shiftLineRight 
*/
changeLine(Board, Y, Value, Way, NewBoard):-
    nth0(Y, Board, Line),
    shiftLine(Line, Way, Value, NewLine), 
    changeBoardLine(Board, 0, Y, NewLine, [], NewBoard).
/*
shift second line left
changeLine([[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 1, 'X', 0, NewBoard).
*/


/**
* Move Piece in Column
* Change Column in Board
* Way is 0 if shiftColUp
* Way is 1 if shiftColDown 
*/
changeCol(Board, X, Value, Way, NewBoard):-
    transpose(Board, TransposeBoard),
    nth0(X, TransposeBoard, Col),
    shiftLine(Col, Way, Value, NewCol), 
    changeBoardLine(TransposeBoard, 0, X, NewCol, [], FinalTransposeBoard),
    transpose(FinalTransposeBoard, NewBoard).
/*
shift second column up
changeCol([[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 1, 'X', 0, NewBoard).
*/


