#!/bin/sh

echo "\n=== run tests for funbox/qa-test ==="

newman run -e qa-test.postman_environment.json -r cli,html,json \
    qa-test.postman_collection.json
