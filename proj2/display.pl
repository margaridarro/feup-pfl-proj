/**
* Print Board
*/
printBoard(Board):-
    nl,
    write('    5   6   7   8   9\n'),
    write('  '),
    print_n('-', 21),
    printLines(Board, 5, 5),
    nl,
    write('  '),
    print_n('-', 21), nl, nl.

/**
* Print Lines
*/
printLines(_, 0, _).
printLines(Board, Lines, Cols):-
    Lines > 0,
        Idx is 5 - Lines,
        Lines1 is Lines - 1,
        nth0(Idx, Board, Line),
        nl,
        write(Idx),
        printLine(Line, Lines1, Cols),
        printLines(Board, Lines1, Cols).

/**
* Print Line
*/
printLine(_, 0, 0):-
   write(' |').
printLine(_, _, 0):- 
    write(' |\n  '),
    print_n('|---', 5), write('|').
printLine(Line, Lines, Cols):-
    Cols > 0,
        Idx is 5 - Cols,
        Cols1 is Cols - 1, 
        nth0(Idx, Line, Elem),
        write(' | '),
        write(Elem),
        printLine(Line, Lines, Cols1).


/**
* Print help information in case of invalid move input
*/
printInputTips:-
    nl,
    write('Your move choice was invalid. Here are some tips:\n'),
    write(' - If you Enter before inserting a valid number, the game will assume you chose 0;\n'),
    write(' - Choose a final position different from the initial one;\n'),
    write(' - You can only move pieces which are placed in the board frame;\n'),
    write(' - You can only move pieces which have your symbol or that are clean;\n'),
    write(' - You can only move pieces to a place that belongs to same line or column as the initial place;\n'),
    write(' - You can only move pieces to a place that belongs to the board frame.\n'),
    nl.

printPlayerTurnMessage(Player):-
    write('Player '),
    write(Player),
    write(', it\'s your turn.\n').



printWinnerMessage(Player):-
    write('Congratulations, Player '), 
    write(Player),
    write('!\nYou have won this Quixo game!\n').

printDrawMessage:-
    write('It\'s a draw, congratulations to both of you!').