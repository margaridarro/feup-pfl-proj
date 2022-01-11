addBoardLine(Board, NewBoard):-
    append(Board, [[' ', ' ', ' ', ' ', ' ']], NewBoard).


resetBoard(Board, 0, FinalBoard):- FinalBoard = Board.
resetBoard(Board, N, FinalBoard):-
    N > 0,
        N1 is N-1,
        addBoardLine(Board, NewBoard),
        resetBoard(NewBoard, N1, FinalBoard).

%call resetBoard([], 5, B)
