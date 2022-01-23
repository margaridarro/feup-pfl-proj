:- [utils].

/**
* Read move input from user
* Perfom movement
*/

makeMove(Board/Player, NewBoard/NewPlayer):-   
    length(Board, Size),
    repeat, (
        readMove(Size, OldY/OldX/NewY/NewX),
        OldY1 is OldY-1, 
        OldX1 is OldX-1, 
        NewY1 is NewY-1, 
        NewX1 is NewX-1, 
        (
            move(Board/Player, OldY1/OldX1/NewY1/NewX1, NewBoard/NewPlayer);
            (   %clear,
                printInputTips(OldY/OldX/NewY/NewX), 
                display_game(Board/Player), !, fail
            )
        )
    ).

/*
* Validate move input
* Perfom specified piece movement
*/
move(Board/Player, OldY/OldX/NewY/NewX, NewBoard/NewPlayer):- % GameState, Move, NewGameState
    length(Board, Size),
    Size1 is Size-1,
    moveValidation(Board/Player, Size1, OldY/OldX/NewY/NewX),
    %clear,
    movePiece(Board, OldY/OldX, NewY/NewX, Player, NewBoard),
    playerHandler(Player, NewPlayer).


valid_moves(Board/Player, Moves):-
    length(Board, L),
    Size is L-1,
    findall(Y/X/NewY/NewX, (checkInitialPos(Board/Player, Size, Y/X), move(Board/Player, Y/X/NewY/NewX, _)), MoveList),
    remove_dups(MoveList, Moves).


/**
* Validate move input
* Ask and read new input if invalid
*/
moveValidation(Board/Player, Size, OldY/OldX/NewY/NewX):-
    validMove(Board/Player, Size, OldY/OldX/NewY/NewX).

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

