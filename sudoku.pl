:- use_module(library(clpfd)).

sudoku(Rows) :-
        % number of rows == 9
        length(Rows, 9),
        % Rows is square (number of columns == 9)
        maplist(same_length(Rows), Rows),
        % Make rows 1D and store in Vs. Assert that all values lie within the range 1..9.
        append(Rows, Vs), Vs ins 1..9,
        % Assert every row contains no duplicate values.
        maplist(all_distinct, Rows),
        % This gets a Columns representation from the Rows.
        % It could go the other way if desired too.
        transpose(Rows, Columns),
        % Assert every column contains no duplicate values.
        maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
        % As is the first row of 9,
        % Bs is the second row of 9, etc.
        blocks(As, Bs, Cs),
        blocks(Ds, Es, Fs),
        blocks(Gs, Hs, Is).

blocks([], [], []).
% Take the first 3 of each row, and that's forms the block,
% which we then assert all_distinct on.
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        % We then run it again on the remaining 6 of each row
        % and on the next recur it runs again on the remaining 3 of each row.
        % On the 3rd iteration, N1,N2,N3 will be empty, so the fact blocks([], [], []). matches.
        blocks(Ns1, Ns2, Ns3).

problem(1, [[_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,3,_,8,5],
            [_,_,1,_,2,_,_,_,_],
            [_,_,_,5,_,7,_,_,_],
            [_,_,4,_,_,_,1,_,_],
            [_,9,_,_,_,_,_,_,_],
            [5,_,_,_,_,_,_,7,3],
            [_,_,2,_,1,_,_,_,_],
            [_,_,_,_,4,_,_,_,9]]).

% ?- problem(1, Rows), sudoku(Rows), maplist(portray_clause, Rows).