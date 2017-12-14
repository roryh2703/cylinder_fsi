# Change the number of processors for the parallel fsifoam job. 
# Edit value for NP=''

# sed:searches, changes lines on keywords
# double '' marks makes sed evaluate varables, not just treat it all as one string

NP='3'    #pass in how many processors

sed -i ''/NB_CORES=/c\NB_CORES=$NP'' Allrun_par.sh  
sed -i ''/numberOfSubdomains/c\numberOfSubdomains\ $NP\;'' fluid/system/decomposeParDict
sed -i ''/numberOfSubdomains/c\numberOfSubdomains\ $NP\;'' solid/system/decomposeParDict

rm -rf fluid/system/sed*      #delete pesky sed files which are created
rm -rf solid/system/sed*
rm -rf sed*
