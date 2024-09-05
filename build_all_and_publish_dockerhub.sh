#!/bin/bash
[ -z "$1" ] && echo "Please enter your DockerHub username, example: sh build_all_and_publish_dockerhub.sh username" && exit 1
echo "dockerhub\`s username: $1"

cd shopfront
mvn clean install -DskipTests=true
if docker build -t $1/djshopfront . ; then
  docker push amen2016/djshopfront
fi
cd ..

cd productcatalogue
mvn clean install -DskipTests=true
if docker build -t $1/djproductcatalogue . ; then
  docker push amen2016/djproductcatalogue
fi
cd ..

cd stockmanager
mvn clean install -DskipTests=true
if docker build -t $1/djstockmanager . ; then
  docker push amen2016/djstockmanager
fi
cd ..
