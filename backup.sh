#!/bin/bash 


#Criando uma variavel para receber o mesmo tipo de nome do dump
dump=dump_`date +%d-%m-%Y_%M`.sql

cd /home/centos/docker-compose

#Acessando o container e executando o comando "pg_dumpall" que cria o dump
/bin/docker exec -t db pg_dump maquinaTest -U postgres  --format=p --no-owner --no-privileges --no-tablespaces --no-unlogged-table-data --inserts > $dump

#Movendo qualquer arquivo do tipo .sql para a pasta Dump-Postgres(repositoio github)
mv *sql dump-postgres/

#Acessando a pasta repositorio
cd dump-postgres/

echo "GIT PULL"
git pull

echo "GIT ADD"
git add $dump

echo "GIT COMMIT"
git commit -m "Dump semanal : "$dump

echo "GIT PUSH"
git push origin master

echo "Removendo Dump"
rm $dump
