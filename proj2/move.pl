move(Player, Board, NewBoard):-
    printPlayerTurnMessage(Player),
    length(Board, Size),
    readMove(Size, OldY/OldX, NewY/NewX), %verified
    moveValidation(Player, Board, Size, OldY/OldX, NewY/NewX),
    clear,
    movePiece(Board, OldY/OldX, NewY/NewX, Player, NewBoard).
/*
move('X', [[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], NewBoard).
move('O', [['O',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], NewBoard).
*/

moveValidation(Player, Board, Size, OldY/OldX, NewY/NewX):-
    write('enter moveValidation'), nl,
    checkMove(Player, Board, Size, OldY/OldX, NewY/NewX), 
    write('Pass check move\n').
moveValidation(Player, Board, Size, _/_, _/_):-
    printBoard(Board),
    printInputTips,
    readMove(Size, OldY/OldX, NewY/NewX),
    moveValidation(Player, Board, Size, OldY/OldX, NewY/NewX).

movePiece(Board, Y/_, Y/NewX, Val, NewBoard):-
    movePieceInLine(Board, Y, NewX, Val, NewBoard).
movePiece(Board, _/X, NewY/X, Val, NewBoard):-
    write('Same X: '), write(X), nl,
    write('New Y: '), write(NewY), nl,
    movePieceInCol(Board, X, NewY, Val, NewBoard).
/*
Valid Move:
movePiece([[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/7, 4/7, 'O', NewBoard). 
movePiece([[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/7, 0/5, 'O', NewBoard). 
*/

movePieceInLine(Board, Y, 1, Val, NewBoard):-
    Y1 is Y-1,
    changeLine(Board, Y1, Val, 1, NewBoard).
movePieceInLine(Board, Y, X, Val, NewBoard):-
    Y1 is Y-1,
    length(Board, Length),
    X == Length,
        changeLine(Board, Y1, Val, 0, NewBoard).

movePieceInCol(Board, X, 1, Val, NewBoard):-
    X1 is X-1,
    changeCol(Board, X1, Val, 1, NewBoard).
movePieceInCol(Board, X, Y, Val, NewBoard):-
    X1 is X-1,
    length(Board, Length),
    Y == Length,
        write('pass size'),
        changeCol(Board, X1, Val, 0, NewBoard).

