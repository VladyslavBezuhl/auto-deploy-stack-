#!/bin/bash

cd /home/jambo2

git pull origin main

docker-compose down
docker-compose up --build -d
