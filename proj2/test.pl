playTestWin:-
    playGame('O', [[' ',' ',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' '],[' ','O',' ',' ',' ']], playing).
    
moveTest(Player, Board):-
    move(Player, Board, NewBoard),
    printBoard(NewBoard).

%moveTest('O', [[' ',' ',' ',' ','O'],[' ',' ',' ',' ',' '],[' ','',' ',' ',' '],[' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ']]).


test(X):-
    resetBoard([], X, X, FinalBoard),
    write(FinalBoard), nl,
    printBoard(FinalBoard).
    
createBoard(Board):-
    resetBoard([], 5, 5, Board),
    printBoard(Board).