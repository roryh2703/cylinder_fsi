#________________________RORY ADD_____________________________________
rm -rf sed*                #sed* files start to build in the current directory

module add foam-extend/4.0 
. $FOAM_SRC_FILE
. $WM_PROJECT_DIR/bin/tools/CleanFunctions
. $WM_PROJECT_DIR/bin/tools/RunFunctions

NB_CORES=4

application=`getApplication`   #i.e. fsifoam

cd fluid
mpirun -np $NB_CORES --allow-run-as-root fsiFoam -parallel &>> log.fsiFoam
