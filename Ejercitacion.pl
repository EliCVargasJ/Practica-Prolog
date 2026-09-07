% ------ Parcial 2024-----------

 % Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido(152, gba(norte), olivos).

% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).

%-------------- Punto 1 ---------------------------------------------
sePuedenCombinar(UnaLinea,OtraLinea):-
    recorrido(UnaLinea,Zona,Calle), recorrido(OtraLinea,Zona,Calle),
    UnaLinea\= OtraLinea.

%---------------- Punto 2 --------------------------------------------

cruzaGralPaz(Linea):- recorrido(Linea,caba,_),recorrido(Linea,gba(_),_).

esDe(caba,caba).
esDe(gba(_),buenosAires).

jurisdiccion(Linea,nacional):-cruzaGralPaz(Linea).

jurisdiccion(Linea,provincial(Provincia)):-
    recorrido(Linea,Zona,_),
    esDe(Zona,Provincia),
    not(cruzaGralPaz(Linea)).

%------------- Punto 3 ---------------------------------------------------

pasanCantidadLineas(Calle,Zona,Cantidad):-
    recorrido(_,Zona,Calle),
    findall(Calle,recorrido(_,Zona,Calle),Lista),
    length(Lista,Cantidad).

calleMasTransitada(Calle, Zona):-
    pasanCantidadLineas(Calle, Zona, Cantidad),
    forall((recorrido(_, Zona, OtraCalle), Calle \= OtraCalle), 
    (pasanCantidadLineas(OtraCalle, Zona, CantidadMenor), 
    Cantidad > CantidadMenor)).

% --------------- Punto 4 ------------------------------------------------

esDeTrasbordo(Calle,Zona):-
    pasanCantidadLineas(Calle,Zona,Cantidad),
    Cantidad >= 3,
    forall(recorrido(Linea,Zona,Calle),jurisdiccion(Linea,nacional)).
    
    
%---------------- Punto 5-------------------------------------------

pasaPorDistintasZonas(Linea):-
    recorrido(Linea, gba(Zona), _),
    recorrido(Linea, gba(OtraZona), _),
    Zona \= OtraZona.

plus(Linea, 50):-
    pasaPorDistintasZonas(Linea).
plus(Linea, 0):-
    not(pasaPorDistintasZonas(Linea)).

valorNormal(Linea, 500):-
    jurisdiccion(Linea, nacional).
valorNormal(Linea, 350):-
    jurisdiccion(Linea, provincial(caba)).
valorNormal(Linea, Valor):-
    jurisdiccion(Linea, provincial(buenosAires)),
    findall(Calle, recorrido(Linea, Calle, _), Calles),
    length(Calles, CantidadCalles),
    plus(Linea, Plus),
    Valor is (25*CantidadCalles) + Plus.

beneficiario(pepito, personalCasaParticular(gba(oeste))).
beneficiario(juanita, estudiantil).
beneficiario(marta, jubilado).
beneficiario(marta, personalCasaParticular(caba)).
beneficiario(marta, personalCasaParticular(gba(sur))).

beneficio(estudiantil, _, 50).
beneficio(personalCasaParticular(Zona), Linea, 0):-
    recorrido(Linea, Zona, _).
beneficio(jubilado, Linea, ValorConBeneficio):-
    valorNormal(Linea, ValorNormal),
    ValorConBeneficio is ValorNormal // 2.

posiblesBeneficios(Persona, Linea, ValorConBeneficio):-
    beneficiario(Persona, Beneficio),
    beneficio(Beneficio, Linea, ValorConBeneficio).

costo(Persona, Linea, CostoFinal):-
    beneficiario(Persona, _),
    recorrido(Linea, _, _),
    posiblesBeneficios(Persona, Linea, CostoFinal),
    forall((posiblesBeneficios(Persona, Linea, OtroValorBeneficiado), OtroValorBeneficiado \= CostoFinal), CostoFinal < OtroValorBeneficiado).

costo(Persona, Linea, ValorNormal):-
   persona(Persona),
   valorNormal(Linea, ValorNormal),
   not(beneficiario(Persona, _)).
   
persona(pepito).
persona(juanita).
persona(tito).
persona(marta).



% ----------------------------- tests -----------

:- begin_tests(bondis).

% ---------------- Punto 1 ----------------

test(punto_1_lineas_combinables, nondet) :-
    sePuedenCombinar(17, 152).

test(punto_1_lineas_no_combinables, [fail]) :-
    sePuedenCombinar(24, 160).


% ---------------- Punto 2 ----------------

test(punto_2_linea_nacional_17, nondet) :-
    jurisdiccion(17, nacional).

test(punto_2_linea_nacional_152, nondet) :-
    jurisdiccion(152, nacional).

test(punto_2_linea_provincial_buenos_aires, nondet) :-
    jurisdiccion(247, provincial(buenosAires)).

test(punto_2_linea_provincial_caba, nondet) :-
    jurisdiccion(10, provincial(caba)).

test(punto_2_linea_no_es_nacional, [fail]) :-
    jurisdiccion(10, nacional).


% ---------------- Punto 3 ----------------

test(punto_3_cantidad_lineas_santa_fe) :-
    pasanCantidadLineas(santaFe, caba, Cantidad),
    Cantidad =:= 3.

test(punto_3_cantidad_lineas_medrano) :-
    pasanCantidadLineas(medrano, caba, Cantidad),
    Cantidad =:= 1.

test(punto_3_calle_mas_transitada, nondet) :-
    calleMasTransitada(santaFe, caba).

test(punto_3_calle_no_mas_transitada, [fail]) :-
    calleMasTransitada(medrano, caba).


% ---------------- Punto 4 ----------------

% En la base original no hay ninguna calle de transbordo verdadera.
test(punto_4_santa_fe_no_es_transbordo, [fail]) :-
    esDeTrasbordo(santaFe, caba).

test(punto_4_no_hay_transbordos, [fail]) :-
    esDeTrasbordo(_, _).


:- end_tests(bondis).