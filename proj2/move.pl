move(Player, Board, NewBoard):-
    printPlayerTurnMessage(Player),
    readMove(OldY/OldX, NewY/NewX),
    moveValidation(Player, Board, OldY/OldX, NewY/NewX),
    clear,
    movePiece(Board, OldY/OldX, NewY/NewX, Player, NewBoard).
/*
move('X', [[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], NewBoard).
move('O', [['O',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], NewBoard).
*/

moveValidation(Player, Board, OldY/OldX, NewY/NewX):-
    checkMove(Player, Board, OldY/OldX, NewY/NewX).
moveValidation(Player, Board, _/_, _/_):-
    printBoard(Board),
    printInputTips,
    readMove(OldY/OldX, NewY/NewX),
    moveValidation(Player, Board, OldY/OldX, NewY/NewX).
/*
Valid Moves:
moveValidation('X', [[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/5, 0/9).
moveValidation('X', [[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/7, 4/7). 
*/


movePiece(Board, Y/_, Y/NewX, Val, NewBoard):-
    movePieceInLine(Board, Y, NewX, Val, NewBoard).
movePiece(Board, _/X, NewY/X, Val, NewBoard):-
    movePieceInCol(Board, X, NewY, Val, NewBoard).
/*
Valid Move:
movePiece([[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/7, 4/7, 'O', NewBoard). 
movePiece([[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], 0/7, 0/5, 'O', NewBoard). 
*/

movePieceInLine(Board, Y, 5, Val, NewBoard):-
    changeLine(Board, Y, Val, 1, NewBoard).
movePieceInLine(Board, Y, 9, Val, NewBoard):-
    changeLine(Board, Y, Val, 0, NewBoard).

movePieceInCol(Board, X, 0, Val, NewBoard):-
    X1 is X-5,
    changeCol(Board, X1, Val, 1, NewBoard).
movePieceInCol(Board, X, 4, Val, NewBoard):-
    X1 is X-5,
    changeCol(Board, X1, Val, 0, NewBoard).


