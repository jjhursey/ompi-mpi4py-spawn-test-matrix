#!/bin/bash

for i in {1..50} ; do
    rm -rf /tmp/*
    echo "================================"
    echo "================================ Iteration $i"
    echo "================================"
    timeout -k 27 25 mpiexec -n 1 python test/runtests.py -v -i test_spawn
    #timeout -k 133 130 mpiexec -n 1 python test/runtests.py -v -i test_spawn
    RTN=$?
    if [[ $RTN != 0 ]] ; then
        echo "=-=-=-=->> Error: Failed with $RTN"
        exit 1
    fi
    echo ""
done

exit 0
