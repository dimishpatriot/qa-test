#! /bin/sh

target=qa-test
url=https://github.com/funbox/qa-test.git

echo "\n=== start server for funbox/qa-test ==="

if [ -d "$target" ];
    then echo "\n- remove old project folder -"
    rm -rf $target && echo "[OK]";
fi

echo "\n- clone project from $url -"
git clone $url $target && echo "[OK]"

echo "\n- build docker-image $target:$timestamp for ruby-on-rails -"
cp Dockerfile $target/Dockerfile
docker build -t $target $target && echo "[OK]"

echo "\n- run docker container $target:$timestamp -"
state=$(docker inspect -f '{{.State.Running}}' $target)
if [ $state = true ];
    then docker stop -t 2 $target
    docker rm $target;
fi;
docker run -d -p 3000:3000 --rm --name $target $target
