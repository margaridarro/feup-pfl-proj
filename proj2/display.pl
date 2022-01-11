% display board

printLine(_, 0, 0):-
   write(' |').
printLine(_, _, 0):- 
    write(' |'), nl,
    write(' '), print_n('|---', 5), write('|').
printLine(Line, Lines, Cols):-
    Cols > 0,
        Idx is 5 - Cols,
        Cols1 is Cols - 1, 
        nth0(Idx, Line, Elem),
        write(' | '),
        write(Elem),
        printLine(Line, Lines, Cols1).

printLines(_, 0, _).
printLines(Board, Lines, Cols):-
    Lines > 0,
        Idx is 5 - Lines,
        Lines1 is Lines - 1,
        nth0(Idx, Board, Line),
        nl,
        printLine(Line, Lines1, Cols),
        printLines(Board, Lines1, Cols).

printBoard(Board):-
    write(' '),
    print_n('-', 21),
    printLines(Board, 5, 5),
    nl,
    write(' '),
    print_n('-', 21).