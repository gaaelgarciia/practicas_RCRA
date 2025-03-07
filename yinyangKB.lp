% Definir el tamaño de la cuadrículaç
gridsize(n).
% Definir filas y columnas (0 a n-1)
row(0..n-1). 
col(0..n-1).

% Asegurar que en cada celda haya exactamente un círculo negro o blanco
1{_drawcircle(X,Y,black); _drawcircle(X,Y,white)}1 :- row(X), col(Y).

% no pueden haber cuatro del mismo color en un bloque 2x2
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
reachable(X, Y, X, Y, C) :- _drawcircle(X, Y, C). % Cada celda se alcanza a sí misma

reachable(X1, Y1, X2, Y2, C) :- 
    adjacent(X1, Y1, X2, Y2),
    _drawcircle(X1, Y1, C),
    _drawcircle(X2, Y2, C).

reachable(X1, Y1, X3, Y3, C) :- 
    reachable(X1, Y1, X2, Y2, C),
    adjacent(X2, Y2, X3, Y3),
    _drawcircle(X3, Y3, C).

mincell(C,Z,T) :- C=(black;white), #min{(X,Y): _drawcircle(X,Y,C) }=M, M=(Z,T).

% Asegurar que todas las celdas negras estén conectadas
:- _drawcircle(X1, Y1, C), _drawcircle(X2, Y2, C), not reachable(X1, Y1, X2, Y2, C).

 #show mincell/3.