/* prolog tutorial  2.2 Two Factorial Definitions */

% Fact / 'Unit clause (no body)'
% Reads: The factorial of 0 is 1.
factorial(0,1).

% Rule
factorial(N,F) :-
   N>0,
   N1 is N-1,
   factorial(N1,F1),
   F is N * F1.

/*------------------------------*/

factorial(0,F,F).

factorial(N,A,F) :-
    N > 0,
    A1 is N*A,
    N1 is N -1,
    factorial(N1,A1,F).