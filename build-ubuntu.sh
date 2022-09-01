#!/bin/bash -e

OMPI_VERSIONS=(4.1.4 4.1.2)
# 4.1.1 - not compatible with system hwloc (configure error)
# 4.2.0 - Flex issue
PMIX_VERSIONS=(3.2.3 4.1.0 4.1.2 4.2.0 4.2.1rc1)

# Default Ubuntu apt install
echo "BUILDING: OMPI from Ubuntu"
docker build -t ompi-test-mpi4py:default -f Dockerfile.ompi-ubuntu .

# Open MPI Release with Internal OpenPMIx
for vompi in ${OMPI_VERSIONS[@]} ; do
    echo "BUILDING: OMPI "$vompi" Release"
    docker build -t ompi-test-mpi4py:v${vompi} --build-arg _BUILD_OMPI_VERSION=${vompi} -f Dockerfile.ompi-ubuntu-release .
done

# Open MPI Release with External OpenPMIx
for vompi in ${OMPI_VERSIONS[@]} ; do
    for vpmix in ${PMIX_VERSIONS[@]} ; do
        echo "BUILDING: OMPI "$vompi" x PMIx "$vpmix
        docker build -t ompi-test-mpi4py:v${vompi}-x-${vpmix} --build-arg _BUILD_OMPI_VERSION=${vompi}  --build-arg _BUILD_OPENPMIX_VERSION=${vpmix} -f Dockerfile.ompi-ubuntu-blend .
    done
    echo "----"
done

echo "======================="
echo "Done"
echo "======================="
docker images ompi-test-mpi4py

exit 0

