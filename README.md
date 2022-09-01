# Testing Matrix for mpi4py with Open MPI on Ubuntu

This assumes that you are using Docker, but Podman should work fine.

## Building images

This will take a while since it is generating 13 builds of Open MPI and OpenPMIx.

```
./build-ubuntu.sh
```

## Running the test matrix

```
./run-ubuntu.sh 2>&1 | tee output.txt
```

Then one it is finished:
```
grep '>>> RESULT' output.txt
```

## Running a single test

Each run will go through 50 iterations of the `test_spawn` test sutie from mpi4py.

Example running Open MPI v4.1.4 release with OpenPMIx v4.1.0:
```
docker run --rm ompi-test-mpi4py:v4.1.4-x-4.1.0 bash -c "cd mpi4py && /home/mpiuser/local/testing/run-mpi4py-spawn-loop.sh"
```