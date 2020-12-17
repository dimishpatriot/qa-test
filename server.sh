#!/bin/sh

target=qa-test
url=https://github.com/funbox/qa-test.git
timestamp=$(date +%s)

echo "\n=== start server for funbox/qa-test ==="

if [ -d "$target" ];
    then echo "\n- remove old project folder -"
    rm -rf $target && echo "[OK]";
fi

echo "\n- clone project from $url -"
git clone $url $target && echo "[OK]"

echo "\n- build docker-image $target:$timestamp for ruby-on-rails -"
cp Dockerfile $target/Dockerfile
docker build -t $target:$timestamp $target && echo "[OK]"

echo "\n- run docker container $target:$timestamp -"
docker run -d -p 3000:3000 --rm --name $target $target:$timestamp
