#!/bin/bash

scriptname=`basename $0`
EXPECTED_ARGS=4
if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $scriptname sinp MH3 MH4 MDM"
    echo "Example: ./$scriptname \"1/sqrt(2)\" 500 200 1"
    exit 1
fi

export PRODHOME=`pwd`
CARDSDIR=${PRODHOME}
name=2HDMPZ2II

sinp=`bc -l <<< $1`
mh3=$2
mh4=$3
mchi=$4

echo ""
echo "sinp = "$sinp
echo "Producing step0 for A mass = "$mh3" GeV "
echo "Producing step0 for a mass = "$mh4" GeV "
echo "Producing step0 for DM mass = "$mchi" GeV "
echo ""


sinpname_temp2=${sinp/./0p}
sinpname_temp=${sinpname_temp2/10p/1p}
sinpname=${sinpname_temp:0:6}
echo $sinpname

newname=${name}\_${sinpname}\_MA${mh3}\_Ma${mh4}\_MDM${mchi}
echo $newname
inputfile=step0_${newname}.root
outputfile=gentuple_${newname}.root
bsub -q8nh -R "rusage[mem=12000]" $PWD/runNtuple.sh $PWD $inputfile $outputfile $name

