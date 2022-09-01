
VALUES=()
# v3.1 fails
VALUES+=(v4.1 v4.0)
VALUES+=(main v5.0.x)
VALUES+=(v4.1.x v4.0.x)

for ver in ${VALUES[@]} ; do
    echo "==================================="
    echo "==================================="
    echo "==================================="
    echo "Running: docker.io/jjhursey/ompi-playground-${ver}:latest ---> OB1"
    echo "==================================="
    docker run --rm -it --user mpiuser  docker.io/jjhursey/ompi-playground-${ver}:latest  bash -c 'cd  ompi-tests-public/singleton/ ; make > /dev/null ; mpirun --version ; export UCX_WARN_UNUSED_ENV_VARS=n ; export OMPI_MCA_pml_ucx_tls=tcp,self,sysv,posix ; export OMPI_MCA_pml=ob1 ; ./run.sh '
    echo "==================================="
    echo "==================================="
    echo "==================================="
    echo "Running: docker.io/jjhursey/ompi-playground-${ver}:latest ---> UCX"
    echo "==================================="
    docker run --rm -it --user mpiuser  docker.io/jjhursey/ompi-playground-${ver}:latest  bash -c 'cd  ompi-tests-public/singleton/ ; make > /dev/null ; mpirun --version ; export UCX_WARN_UNUSED_ENV_VARS=n ; export OMPI_MCA_pml_ucx_tls=tcp,self,sysv,posix ; export OMPI_MCA_pml=ucx ; ./run.sh '
    echo ""
    echo ""
    echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    echo ""
    echo ""
done
