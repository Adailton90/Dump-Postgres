#!/bin/bash 


#Criando uma variavel para receber o mesmo tipo de nome do dump
DATA=dump_`date +%d-%m-%Y`.sql

#Acessando o container e executando o comando "pg_dumpall" que cria o dump
docker exec -t db pg_dumpall -c -U postgres > $DATA

#Movendo qualquer arquivo do tipo .sql para a pasta Dump-Postgres(repositoio github)
mv *sql Dump-Postgres/

#Acessando a pasta repositorio
cd Dump-Postgres/

echo "GIT ADD"
git add $DATA

echo "GIT COMMIT"
git commit -m "Dump semanal : "$DATA

echo "GIT PUSH"
git push origin master

