acesso(campinas, "São Paulo", anhanguera, 90, (0:50)).
acesso(campinas, "São Paulo", bandeirantes, 95, (0:45)).
acesso(campinas, araras, rod1, 80, (0:55)).
acesso(araras, "Rio Claro", rod2, 30, (0:20)).
acesso(araras, limeira, rod3, 40, (0:25)).
acesso(campinas, limeira, rod4, 50, (0:35)).

% acesso(Origem, Destino, Rodovia, Distancia, Tempo) :- !,acesso(Destino,
% Origem, Rodovia, Distancia, Tempo).

maodupla(O,D,R,C,T) :- acesso(D,O,R,C,T).

vai(O,D,R,C,T) :- acesso(O,D,R,C,T);maodupla(O,D,R,C,T).

% --------------------- 1 - Rota Direta -----------------------
rotadireta(CidadeA,CidadeB,Rodovia) :- vai(CidadeA,CidadeB,Rodovia,_,_).

% --------------------- 2 - Caminho ---------------------------
caminho(CidadeA, CidadeA, []) :- !.
caminho(CidadeA, CidadeB, [Rodovia]) :- vai(CidadeA,CidadeB,Rodovia,_,_),!.
caminho(CidadeA, CidadeB, [HeadRod|TailRod]) :-
    stepcaminho(CidadeA, CidadeB, [HeadRod|TailRod], [],_,_).
%caminho(CidadeA, CidadeB, [HeadRod|TailRod]) :-
    %CidadeA \= CidadeB,
    %vai(CidadeA, CidadeC, HeadRod,_,_),
    %caminho(CidadeC, CidadeB, TailRod).
    %stepcaminho(CidadeC,CidadeB,[HeadRod|TailRod],

stepcaminho(CidadeA,CidadeA,[],_,Distancia,(H:M)) :- Distancia is 0, H is 0, M is 0.
stepcaminho(CidadeA,CidadeB,[HeadRod|TailRod],Caminho,Distancia,Tempo) :-
    vai(CidadeA,CidadeC,HeadRod,Distancia2,Tempo2),
    naoexiste(CidadeC,Caminho),
    stepcaminho(CidadeC,CidadeB,TailRod,[CidadeA|Caminho],Distancia1,Tempo1),
    Distancia is Distancia2 + Distancia1,
    somatempo(Tempo1, Tempo2, Tempo).

naoexiste(_,[]).
naoexiste(X,[H|T]) :- X\=H, naoexiste(X,T).

somatempo((H1:M1),(H2:M2),(Hf:Mf)) :-
    Temp is M1 + M2,
    Temp =< 59,
    Mf is Temp,
    Hf is H1 + H2, !;
    Mf is M1 + M2 - 60,
    Hf is H1 + H2 + 1.

% --------------------- 3 - Menor Caminho ---------------------
menorCaminho(CidadeA,CidadeB,CaminhoKm) :-
    findall(X,stepcaminho(CidadeA,CidadeB,_,[],X,_),L),
    encontraMenorValor(L,CaminhoKm).

encontraMenorValor([Ultimo],Ultimo).
encontraMenorValor([Head1, Head2|Tail], Menor) :-
    Head1 =< Head2,
    encontraMenorValor([Head1|Tail],Menor),!;
    encontraMenorValor([Head2|Tail],Menor).

% --------------------- 4 - Tempo do Menor Caminho ------------
tempoMenorCaminho(CidadeA,CidadeB,Tempo) :-
    findall([Dist,Temp],stepcaminho(CidadeA,CidadeB,_,[],Dist,Temp),L),
    encontraMenorPar(L,_,Tempo).

encontraMenorPar([[Dist,T]],Dist,T) :- number(Dist).%, atom(H), atom(M).
encontraMenorPar([[D1,T1],[D2,T2]|Tail], D, T) :-
    D1 =< D2,
    encontraMenorPar([[D1,T1]|Tail],D,T),!;
    encontraMenorPar([[D2,T2]|Tail],D,T).

% --------------------- 5 - Menor Tempo -----------------------
menorTempo(CidadeOrigem, CidadeDestino, Tempo) :-
    findall(X,stepcaminho(CidadeOrigem, CidadeDestino,_,[],_,X),L),
    encontraMenorTempo(L,Tempo).

encontraMenorTempo([(UltimaHora:UltimoMin)], (UltimaHora:UltimoMin)).
encontraMenorTempo([(H1:M1),(H2:M2)|Tail],Menor) :-
    H1 < H2,
    encontraMenorTempo([(H1:M1)|Tail],Menor),!;
    H2 < H1,
    encontraMenorTempo([(H2:M2)|Tail],Menor),!;
    M1 < M2,
    encontraMenorTempo([(H1:M1)|Tail],Menor),!;
    encontraMenorTempo([(H2:M2)|Tail],Menor),!.
