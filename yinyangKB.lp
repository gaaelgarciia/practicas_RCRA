% Definir el tamaño de la cuadrícula
gridsize(4).

% Definir filas y columnas
row(0..N) :- gridsize(N).
col(0..N) :- gridsize(N).

% Asegurar que en cada celda (X, Y) haya exactamente un círculo negro o blanco
1{_drawcircle(X,Y,black); _drawcircle(X,Y,white)}1 :- row(X), col(Y).

% No puede haber cuatro negras juntas
:- _drawcircle(X,Y,black), _drawcircle(X+1,Y,black), _drawcircle(X,Y+1,black), _drawcircle(X+1,Y+1,black).

% No puede haber cuatro blancas juntas
:- _drawcircle(X,Y,white), _drawcircle(X+1,Y,white), _drawcircle(X,Y+1,white), _drawcircle(X+1,Y+1,white).

% Definir adyacencia ortogonal
adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), row(X2), col(Y2),
    X2 = X1 + 1, Y2 = Y1.

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), row(X2), col(Y2),
    X2 = X1 - 1, Y2 = Y1.

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), row(X2), col(Y2),
    X2 = X1, Y2 = Y1 + 1.

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), row(X2), col(Y2),
    X2 = X1, Y2 = Y1 - 1.

% Asegurar que cada celda negra tenga al menos una celda negra adyacente
:- _drawcircle(X, Y, black), not  1{ _drawcircle(X2, Y2, black) : adjacent(X, Y, X2, Y2) }.

:- _drawcircle(X, Y, white), not  1{ _drawcircle(X2, Y2, white) : adjacent(X, Y, X2, Y2) }.

% Asegurar que cada celda negra tenga al menos una celda negra adyacente
:- _drawcircle(X, Y, black), not 1 { _drawcircle(X2, Y2, black) : adjacent(X, Y, X2, Y2) }.

:- _drawcircle(X, Y, white), not 1 { _drawcircle(X2, Y2, white) : adjacent(X, Y, X2, Y2) }.
