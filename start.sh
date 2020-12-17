#!/bin/sh

echo "\n=== MAIN ==="

# step 1. install main programs (if need)
chmod +x install.sh && ./install.sh

# step 2. create and run server in docker container on localhost:3000
./server.sh &

# step 3. run tests in newman and create reports in the folder "newman"
./test.sh

# step 4. stop, the container is automatically deleted using the key "--rm"
docker stop qa-test
