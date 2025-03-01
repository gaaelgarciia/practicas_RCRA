% Definir el tamaño de la cuadrícula
gridsize(5).

% Definir filas y columnas
row(0..N) :- gridsize(N).
col(0..N) :- gridsize(N).

% Asegurar que en cada celda (X, Y) haya exactamente un círculo negro o blanco
1{_drawcircle(X,Y,black); _drawcircle(X,Y,white)}1 :- row(X), col(Y).

% No puede haber cuatro juntas del mismo color (negras o blancas)
:- _drawcircle(X, Y, C), _drawcircle(X+1, Y, C), _drawcircle(X, Y+1, C), _drawcircle(X+1, Y+1, C).

% Evitar el patrón de tablero (con dos colores alternados en los 4 cuadros adyacentes)
:- _drawcircle(X, Y, C1), _drawcircle(X+1, Y+1, C1), _drawcircle(X+1, Y, C2), _drawcircle(X, Y+1, C2), C1 != C2.



% Definir adyacencia ortogonal
adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), row(X2), col(Y2),
    X2 = X1 + 1, Y2 = Y1, X2 <= 5.

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), row(X2), col(Y2),
    X2 = X1 - 1, Y2 = Y1, X2 >= 0.

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), row(X2), col(Y2),
    X2 = X1, Y2 = Y1 + 1,Y2<= 5 .

adjacent(X1, Y1, X2, Y2) :-
    row(X1), col(Y1), row(X2), col(Y2),
    X2 = X1, Y2 = Y1 - 1, Y2>=0.

% Asegurar que cada celda negra tenga al menos una celda negra adyacente
:- _drawcircle(X, Y, C), not  1{ _drawcircle(X2, Y2, C) : adjacent(X, Y, X2, Y2) }.


connected(X1, Y1, X2, Y2) :-
    _drawcircle(X1, Y1, C), _drawcircle(X2, Y2, C),
    adjacent(X1, Y1, X2, Y2).

% Conectividad transitiva: Si A está conectada a B y B está conectada a C, entonces A está conectada a C
connected(X1, Y1, X3, Y3) :-
    connected(X1, Y1, X2, Y2),
    connected(X2, Y2, X3, Y3).

% Asegurar que todas las celdas negras estén conectadas
:- _drawcircle(X1, Y1, C), _drawcircle(X2, Y2, C), not connected(X1, Y1, X2, Y2).

