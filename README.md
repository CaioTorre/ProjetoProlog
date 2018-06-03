# Projeto de Paradigmas de Programação A - Prolog
## Comandos Exigidos
1. `rotaDireta/3`: Verificar se é possível ir de uma cidade a outra através de uma rodovia, diretamente, sem passar por outras cidades.
```prolog
?- rotaDireta(CidadeA, CidadeB, Rodovia). 
```
2. `caminho/3`: Verificar se é possível ir de uma cidade a outra, ainda que passando por outras cidades.
```prolog
?- caminho(CidadeA, CidadeB, Rodovias). 
```
3. `menorCaminho/3`: Verificar o menor caminho (em quilômetros) entre duas cidades, ainda que passando por outras cidades.
```prolog
?- menorCaminho(CidadeA, CidadeB, CaminhoKm). 
```
4. `tempoMenorCaminho/3`:  Exibir o tempo do menor caminho em quilômetros, considerando todas as rodovias percorridas. O tempo é exibido da forma (Horas:Minutos).
```prolog
?- tempoMenorCaminho(CidadeA, CidadeB, Tempo).
```
5. `menorTempo/3`: Exibir o menor tempo (total) entre duas cidades, ainda que passando por outras cidades, da mesma forma que o anterior.
```prolog
?- menorTempo(CidadeOrigem, CidadeDestino, Tempo). 
```
## Comandos Extras
1. `caminhoSimplificado/3`: Exibe o caminho entre duas cidades, omitindo nomes de rodovias duplicados consecutivamente (ABBBCB => ABCB).
```prolog
?- caminhoSimplificado(CidadeA, CidadeB, Rodovias).
```
2. `caminhosSimplificados/3`: Exibe todos os caminhos possíveis entre duas cidades, semelhante ao anterior (utilizando findall).
```prolog
?- caminhosSimplificados(CidadeA, CidadeB, ListaRodovias).
```
3. `listaCidades/1`: Exibe uma lista com todas as cidades disponiveis.
```prolog
?- listaCidades(Lista).
```
4. `caminhoCidades/4`: Semelhante a `caminho/3`, mas exibe listas com as cidades, ao invés de rodovias.
```prolog
?- caminhoCidades(CidadeA, CidadeB, [], Caminho).
```
5. `hamiltonian/1`: Exibe uma lista contendo todos os caminhos hamiltonianos possíveis.
```prolog
?- hamiltonian(Path).
```
