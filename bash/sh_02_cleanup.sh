#!/bin/bash

docker container rm --force app01_pgadmin
docker container rm --force db01_postgres

docker volume rm --force hackathon_app01
docker volume rm --force hackathon_db01

docker network rm hackathon_backend