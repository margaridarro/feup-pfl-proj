:- use_module(library(random)).
:- use_module(library(lists)).

valid_moves(Board/Player, Moves):-
    length(Board, L),
    Size is L-1,
    findall(Y/X/NewY/NewX, (checkInitialPos(Board/Player, Size, Y/X), move(Board/Player, Y/X/NewY/NewX, _)), MoveList),
    remove_dups(MoveList, Moves).
/**
* Level 1 leads to random move choice
* Level 2 leads to the best immediate move choice
*/
choose_move(GameState, 1, Move):-
    valid_moves(GameState, Moves),
    random_member(Move, Moves).

