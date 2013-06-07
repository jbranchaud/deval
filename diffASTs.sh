#!/bin/sh

baseDir=$1
sourceDir=$2
destDir=$3

#echo $baseDir
#echo $sourceDir
#echo $destDir

cd $baseDir
for baseFile in $(find . -name '*.java')
do

    filename=${baseFile##*/}
    java -cp $testHome/tools:$testHome/tools/tools.jar cse.unl.edu.ast.ASTDiffer -original ${baseFile/\./$baseDir} -modified ${baseFile/\./$sourceDir} -heu -xml -file $filename -dir $destDir

done
