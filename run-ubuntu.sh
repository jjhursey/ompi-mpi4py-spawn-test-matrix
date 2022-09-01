#!/bin/bash

OMPI_VERSIONS=(4.1.4 4.1.2)
# 4.1.1 - not compatible with system hwloc (configure error)
# 4.2.0 - Flex issue
PMIX_VERSIONS=(3.2.3 4.1.0 4.1.2 4.2.0 4.2.1rc1)

# Default Ubuntu apt install
echo "RUNNING: OMPI from Ubuntu"
docker run --rm ompi-test-mpi4py:default \
       bash -c "cd mpi4py && /home/mpiuser/local/testing/run-mpi4py-spawn-loop.sh"
RTN=$?
if [[ $RTN != 0 ]] ; then
    echo "------>>> RESULT: FAILURE --  OMPI from Ubuntu"
else
    echo "------>>> RESULT: SUCCESS --  OMPI from Ubuntu"
fi

# Open MPI Release with Internal OpenPMIx
for vompi in ${OMPI_VERSIONS[@]} ; do
    echo "RUNNING: OMPI "$vompi" Release"
    docker run --rm ompi-test-mpi4py:v${vompi} \
           bash -c "cd mpi4py && /home/mpiuser/local/testing/run-mpi4py-spawn-loop.sh"
    RTN=$?
    if [[ $RTN != 0 ]] ; then
        echo "------>>> RESULT: FAILURE --  OMPI "$vompi" Release"
    else
        echo "------>>> RESULT: SUCCESS --  OMPI "$vompi" Release"
    fi
done

# Open MPI Release with External OpenPMIx
for vompi in ${OMPI_VERSIONS[@]} ; do
    for vpmix in ${PMIX_VERSIONS[@]} ; do
        echo "RUNNING: OMPI "$vompi" x PMIx "$vpmix
        docker run --rm ompi-test-mpi4py:v${vompi}-x-${vpmix} \
           bash -c "cd mpi4py && /home/mpiuser/local/testing/run-mpi4py-spawn-loop.sh"
        RTN=$?
        if [[ $RTN != 0 ]] ; then
            echo "------>>> RESULT: FAILURE --  OMPI "$vompi" x PMIx "$vpmix
        else
            echo "------>>> RESULT: SUCCESS --  OMPI "$vompi" x PMIx "$vpmix
        fi
    done
    echo "----"
done

echo "======================="
echo "Done"
echo "======================="

exit 0

