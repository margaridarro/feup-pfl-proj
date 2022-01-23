/**
* Print Board
*/
printBoard(Board):-
    write('\n '),
    length(Board, L),
    Size is L+1,
    printHorizontalPlaces(Size, Size),
    write('\n  -'),
    Hifens is 4*L,
    print_n('-', Hifens),
    printLines(Board, Size, Size),
    write('\n  -'),
    print_n('-', Hifens), nl, nl.


printHorizontalPlaces(1, _).
printHorizontalPlaces(N, L):-
    N1 is N-1,
    write('   '),
    House is L-N1,
    write(House),
    printHorizontalPlaces(N1, L).

/**
* Print Board Lines
*/
printLines(_, 1, _).
printLines(Board, Lines, Cols):-
    Lines > 1,
        Idx is Cols - Lines,
        Lines1 is Lines - 1,
        nth0(Idx, Board, Line),
        nl,
        LineNumber is Idx+1,
        write(LineNumber),
        printLine(Line, Lines1, Cols, Cols),
        printLines(Board, Lines1, Cols).

/**
* Print Board Line
*/
printLine(_, 1, 1, _):-
   write(' |').
printLine(_, _, 1, Size):- 
    write(' |\n  '),
    Size1 is Size-1,
    print_n('|---', Size1), write('|').
printLine(Line, Lines, Cols, Size):-
    Cols > 1,
        Idx is Size - Cols,
        Cols1 is Cols - 1, 
        nth0(Idx, Line, Elem),
        write(' | '),
        write(Elem),
        printLine(Line, Lines, Cols1, Size).


/**
* Print help information in case of invalid move input
*/
%printInputTips(OldY/OldX/NewY/NewX):-
printInputTips:-
    clear,
    %write('\nYour move attempt: ('), write(OldY), write(', '), write(OldX),
    %write(') -> ('), write(NewY), write(', '), write(NewX), write(')'),
    %write(' was invalid.\n\nHere are some tips:\n'),
    write('\nYour move attempt was invalid.\n\nHere are some tips:\n'),

    write(' - If you Enter before inserting a valid number, the game will assume you chose 0;\n'),
    write(' - Choose a final position different from the initial one;\n'),
    write(' - You can only move pieces which are placed in the board frame;\n'),
    write(' - You can only move pieces which have your symbol or that are clean;\n'),
    write(' - You can only move pieces to a place that belongs to same line or column as the initial place;\n'),
    write(' - You can only move pieces to a place that belongs to the board frame.\n'),
    nl.



/**
* Display GameState
* Board and next player to make a move
*/
display_game(Board/Player):-
    printBoard(Board),
    printPlayerTurnMessage(Player).

/**
* Print message informing which player is playing
*/
printPlayerTurnMessage(Player):-
    write('Player '),
    write(Player),
    write(', it\'s your turn.\n').

/**
* Print message informing that a player has won
*/
printWinMessage(Player):-
    write('Congratulations, Player '), 
    write(Player),
    write('!\nYou have won this Quixo game!\n').

/**
* Print message informing that players have arrived to a draw
*/
printDrawMessage:-
    write('It\'s a draw, congratulations to both of you!\n').

/**
* Print main menu information and options
*/
printMenu:-
    write('Welcome to Quixo!\nSelect one of the following options:\n'),
    write('  1. Multiplayer\n'),
    write('  2. Singleplayer\n').

/**
* Print back to menu message after a game has finished
* Read unused random input from user
*/
printReturnToMenuMessage:-
    write('Press any key to return to menu'),
    read_number(_).

printPcPlayingMessage:-
    write('\nPlayer X is thinking, press any key to hurry them up!'), read_number(_).
