#________________________RORY ADD_____________________________________
read -p "Press [Enter] key to clean directories..."

rm -rf sed*                #sed* files start to build in the current directory

module add foam-extend/4.0 
. $FOAM_SRC_FILE
. $WM_PROJECT_DIR/bin/tools/CleanFunctions
. $WM_PROJECT_DIR/bin/tools/RunFunctions

rm -rf sed*       #random 

m4 ./fluid/constant/polyMesh/blockfluidMesh.m4 > fluid/constant/polyMesh/blockMeshDict
m4 ./solid/constant/polyMesh/blocksolidMesh.m4 > solid/constant/polyMesh/blockMeshDict

sed -i s/tcsh/sh/g *Links
./removeSerialLinks fluid solid           #takes fluid and solid as input $1 and $2
./makeSerialLinks fluid solid

cd fluid

# Source tutorial clean functions
cleanCase
\rm -f constant/polyMesh/boundary
\rm -rf history
\rm -f constant/solid/polyMesh/boundary
\rm -rf constant/solid/polyMesh/[c-z]*
\rm -rf ../solid/VTK

\rm -f *.ps
\rm -f *.pdf

cd ../solid
cleanCase     %removes times directories, log files, processor directories, etc...

cd ..
./removeSerialLinks fluid
cd fluid
touch fluid.foam
cd ..

rm -rf sed*     #remove pesky sed files

find . -type f -name '*~' -exec rm -f '{}' \;  #delete emacs save files (tildes)
