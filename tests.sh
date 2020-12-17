#! /bin/sh

echo "\n=== run tests for funbox/qa-test ==="
target=qa-test
state=$(docker inspect -f '{{.State.Running}}' $target)

# check container work
if [ $state = true ];
    then echo;
else
    echo "\n- container will be run -"
    docker run -d -p 3000:3000 --rm --name $target $target && echo "[OK]";
fi;

echo "\n- start tests -"
newman run -e qa-test.postman_environment.json -r cli,html,json \
    qa-test.postman_collection.json && echo "[OK]"

