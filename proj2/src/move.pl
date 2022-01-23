:- [utils].

/**
* Read move input from user until valid
* Perfom movement
*/
makeMove(Board/Player, NewBoard/NewPlayer):-   
    length(Board, Size),
    readMove(Size, OldY/OldX/NewY/NewX),
    OldY1 is OldY-1, 
    OldX1 is OldX-1, 
    NewY1 is NewY-1, 
    NewX1 is NewX-1, 
    move(Board/Player, OldY1/OldX1/NewY1/NewX1, NewBoard/NewPlayer).
makeMove(Board/Player, NewGameState):-
    clear, 
    printInputTips,
    printBoard(Board),
    makeMove(Board/Player, NewGameState).

/*
* Validate move input
* Perfom specified piece movement
*/
move(Board/Player, OldY/OldX/NewY/NewX, NewBoard/NewPlayer):- % GameState, Move, NewGameState
    length(Board, Size),
    Size1 is Size-1,
    validMove(Board/Player, Size1, OldY/OldX/NewY/NewX),
    movePiece(Board, OldY/OldX, NewY/NewX, Player, NewBoard),
    playerHandler(Player, NewPlayer).

/**
* Perform piece movement
* Saves updated board after move in NewBoard
*/
movePiece(Board, Y/OldX, Y/NewX, Val, NewBoard):-
    movePieceInLine(Board, Y, OldX, NewX, Val, NewBoard).
movePiece(Board, OldY/X, NewY/X, Val, NewBoard):-
    movePieceInCol(Board, X, OldY, NewY, Val, NewBoard).


/**
* Perform piece movement in the same line
*/
movePieceInLine(Board, Y, OldX, 0, Val, NewBoard):-
    changeLine(Board, Y, OldX, Val, 1, NewBoard).
movePieceInLine(Board, Y, OldX, _, Val, NewBoard):-
    changeLine(Board, Y, OldX, Val, 0, NewBoard).

/**
* Perform piece movement in the same column
*/
movePieceInCol(Board, X, OldY, 0, Val, NewBoard):-
    changeCol(Board, X, OldY, Val, 1, NewBoard).
movePieceInCol(Board, X, OldY, _, Val, NewBoard):-
    changeCol(Board, X, OldY, Val, 0, NewBoard).

