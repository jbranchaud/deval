#!/bin/sh

# VoldemortS1
#
# This shell script will setup scenario1 for the Voldemort project.

if [ -z "$DEVAL" ]
then
    echo "Your DEVAL variable is emtpy, please run setup.sh."
    exit 1
fi

if [ -z "$DEVALSUB" ]
then
    echo "Your DEVALSUB variable is empty, please run setup.sh."
    exit 1
fi

# setup the directory structure for this project scenario
configfile=$DEVAL/subjects/voldemort/voldemortE.yaml
python $DEVAL/dirify.py $configfile

# name the repository clone variables
tmpdir=$DEVAL/tmp
reponame=voldemortE
repodir=$tmpdir/$reponame

# checkout the Voldemort project, overwrite if it is already there.
voldemortURL=https://github.com/jbranchaud/voldemortE.git
git clone $voldemortURL $repodir

# go to the repository directory so that we can start jumping to different
# branches
cd $repodir

# name the branches here:
basebranch=scenario1
sourcebranch=scenario1-s1
targetbranch=scenario1-t1

# name the directories of interest
projectsrc=src/java/voldemort
projectbin=bin/voldemort
projectlib=lib

# name the destination directories
destsrc=$DEVALSUB/voldemortE/scenario1/base/src
destbin=$DEVALSUB/voldemortE/scenario1/base/bin
destlib=$DEVALSUB/voldemortE/scenario1/base/lib

echo "*************************************"
echo "Setting up the base for scenario1"
# checkout the base branch for scenario1
git checkout -b $basebranch origin/$basebranch
# build the project
ant build
# grab each the src, bin, and lib and put them where they belong
cp -R $projectsrc $destsrc
cp -R $projectbin $destbin
cp -R $projectlib/* $destlib

# name the destination directories
destsrc=$DEVALSUB/voldemortE/scenario1/source1/src
destbin=$DEVALSUB/voldemortE/scenario1/source1/bin
destlib=$DEVALSUB/voldemortE/scenario1/source1/lib

echo "*************************************"
echo "Setting up the source for scenario1"
# checkout the source1 branch for scenario1
git checkout -b $sourcebranch origin/$sourcebranch
# build the project
ant build
# grab each the src, bin, and lib and put them where they belong
cp -R $projectsrc $destsrc
cp -R $projectbin $destbin
cp -R $projectlib/* $destlib

# name the destination directories
destsrc=$DEVALSUB/voldemortE/scenario1/target1/src
destbin=$DEVALSUB/voldemortE/scenario1/target1/bin
destlib=$DEVALSUB/voldemortE/scenario1/target1/lib

echo "*************************************"
echo "Setting up the target for scenario1"
# checkout the target1 branch for scenario1
git checkout -b $targetbranch origin/$targetbranch
# build the project
ant build
# grab each the src, bin, and lib and put them where they belong
cp -R $projectsrc $destsrc
cp -R $projectbin $destbin
cp -R $projectlib/* $destlib

# add the ROI.txt to the project
sourceROI=$DEVAL/subjects/voldemort/scenario1-roi1.txt
destROI=${DEVALSUB}/voldemortE/scenario1/config1/target1/roi1.txt
cp $sourceROI $destROI
sourceROI=$DEVAL/subjects/voldemort/scenario1-roi2.txt
destROI=${DEVALSUB}/voldemortE/scenario1/config1/target1/roi2.txt
cp $sourceROI $destROI
sourceROI=$DEVAL/subjects/voldemort/scenario1-roi3.txt
destROI=${DEVALSUB}/voldemortE/scenario1/config1/target1/roi3.txt
cp $sourceROI $destROI
sourceROI=$DEVAL/subjects/voldemort/scenario1-roi4.txt
destROI=${DEVALSUB}/voldemortE/scenario1/config1/target1/roi4.txt
cp $sourceROI $destROI

# get out of the repository and delete it
cd $DEVAL
rm -rf $repodir

# create the AST Diff XML files for the base->source and base->target
baseSrc=$DEVALSUB/voldemortE/scenario1/base/src
sourceSrc=$DEVALSUB/voldemortE/scenario1/source1/src
targetSrc=$DEVALSUB/voldemortE/scenario1/target1/src
baseToSource=$DEVALSUB/voldemortE/scenario1/config1/source1/astdiff
baseToTarget=$DEVALSUB/voldemortE/scenario1/config1/target1/astdiff
# ASTDiff for base->source
echo "*************************************"
echo "Generating ASTDiffs for Base -> Source1"
$DEVAL/diffASTs.sh $baseSrc $sourceSrc $baseToSource
# ASTDiff for base->target
echo "*************************************"
echo "Generating ASTDiffs for Base -> Target1"
$DEVAL/diffASTs.sh $baseSrc $targetSrc $baseToTarget

echo "The project has been initialized for evaluation."
