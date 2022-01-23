valid_moves(Board/Player, Moves):-
    length(Board, L),
    Size is L-1,
    findall(Y/X/NewY/NewX, (checkInitialPos(Board/Player, Size, Y/X), move(Board/Player, Y/X/NewY/NewX, _)), MoveList),
    remove_dups(MoveList, Moves).