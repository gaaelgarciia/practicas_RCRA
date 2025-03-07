% Definir el tamaño de la cuadrícula
gridsize(n).
% Definir filas y columnas (0 a n-1)
row(0..n-1). 
col(0..n-1).

% Asegurar que en cada celda haya exactamente un círculo negro o blanco
1{_drawcircle(X,Y,black); _drawcircle(X,Y,white)}1 :- row(X), col(Y).

% No pueden haber cuatro del mismo color en un bloque 2x2
:- row(X), col(Y), X < n-1, Y < n-1,
   _drawcircle(X, Y, C), _drawcircle(X+1, Y, C),
   _drawcircle(X, Y+1, C), _drawcircle(X+1, Y+1, C).

% Evitar el patrón de tablero (checkered pattern)
:- row(X), col(Y), X < n-1, Y < n-1,
   _drawcircle(X, Y, C1), _drawcircle(X+1, Y+1, C1),
   _drawcircle(X+1, Y, C2), _drawcircle(X, Y+1, C2),
   C1 != C2.

% Definir adyacencia ortogonal
adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), X2 = X1 + 1, Y2 = Y1, X1 < n-1.

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), X2 = X1 - 1, Y2 = Y1, X1 > 0.

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), X2 = X1, Y2 = Y1 + 1, Y1 < n-1.

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), X2 = X1, Y2 = Y1 - 1, Y1 > 0.

% Definir alcanzabilidad para cada color
reachable(X, Y, C) :- mincell(C, X, Y).

reachable(X2, Y2, C) :- 
    reachable(X1, Y1, C),
    adjacent(X1, Y1, X2, Y2),
    _drawcircle(X2, Y2, C).

% Determinar la celda mínima de cada color
mincell(C,Z,T) :- C=(black;white), #min{(X,Y): _drawcircle(X,Y,C)}=M, M=(Z,T).

% Asegurar que la celda mínima tenga el color asignado
_drawcircle(Z, T, C) :- mincell(C, Z, T).

% Asegurar que todas las celdas negras estén conectadas a partir de la celda mínima
:- mincell(C, X0, Y0), _drawcircle(X1, Y1, C), not reachable(X1, Y1, C).

% Capture adjacent different color pairs on each border
border_pair(top, Y, (C1, C2)) :- row(0), col(Y), Y < n-1, _drawcircle(0,Y,C1), _drawcircle(0,Y+1,C2), C1 != C2.
border_pair(bottom, Y, (C1, C2)) :- row(n-1), col(Y), Y < n-1, _drawcircle(n-1,Y,C1), _drawcircle(n-1,Y+1,C2), C1 != C2.
border_pair(left, X, (C1, C2)) :- col(0), row(X), X < n-1, _drawcircle(X,0,C1), _drawcircle(X+1,0,C2), C1 != C2.
border_pair(right, X, (C1, C2)) :- col(n-1), row(X), X < n-1, _drawcircle(X,n-1,C1), _drawcircle(X+1,n-1,C2), C1 != C2.

% :- #count{B1,P1: border_pair(B1, P1, (black, white))} > 1 , #count{B2,P2: border_pair(B2, P2, (white, black))} > 1.
:- N = #sum {1,B,P : border_pair(B,P,(white,black)); 1,B,P : border_pair(B,P,(black,white))}, N > 2.