%----------- Parcial 2024 Turf! -------------

% atom_length(Variable,Longitud). 

% ------- Punto 1 --------------------

% jockey (Nombre, Altura, Peso).
jockey(valdiviesco,155,52).
jockey(leguisamo,161,49).
jockey(lezcano,149,50).
jockey(baratucci,156,55).
jockey(falero,157,52).

%caballo(Nombre).
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

%preferencia(NombreCaballo,jockey).

preferencia(botafogo,Nombre):-jockey(Nombre,_, Peso), Peso < 52.
preferencia(botafogo,baratucci).
preferencia(oldMan,Nombre):- jockey(Nombre,_,_), atom_length(Nombre,Longitud),Longitud > 7. 
preferencia(energica,Nombre):- jockey(Nombre,_,_), not(preferencia(botafogo, Nombre)).
preferencia(matBoy,Nombre):- jockey(Nombre,Altura,_), Altura > 170.

% caballeriza (NombreCaballeriza,jockey).

caballeriza(elTute, valdiviesco).
caballeriza(elTute, falero).
caballeriza(lasHormigas, lezcano).
caballeriza(elCharabon, baratucci).
caballeriza(elCharabon, leguisamo).

% gano(Premio, caballo).

gano(elGranPremioNacional,botafogo).
gano(elGranPremioRepublica,botafogo).
gano(elGranPremioRepublica,oldMan).
gano(elCampeonatoPalermoDeOro,oldMan).
gano(matBoy,elGranPremioCriadores).


% ----------- Punto 2 -----------------

prefiereAMasDeUno(Caballo):-
    caballo(Caballo),
    preferencia(Caballo,Jockey),
    preferencia(Caballo,OtroJockey),
    Jockey\=OtroJockey.

% ------------- Punto 3 ----------------------

aborrece(Caballo,Caballeriza):-
    caballo(Caballo),
    not((caballeriza(Caballeriza,Jockey),preferencia(Caballo,Jockey))).
   
   % caballeriza(Caballeriza,Jockey),
   % not(preferencia(Caballo,Jockey)).



