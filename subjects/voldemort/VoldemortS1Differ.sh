#!/bin/sh

# VoldemortS1Differ.sh
#
# This shell script is going to create the AST Diff XML files for each of
# the project's Java files by using the ASTro diffing tool.

#java -cp $testHome/tools:$testHome/tools/tools.jar cse.unl.edu.ast.ASTDiffer
#-original $testHome/version0/generics/Example00.java -modified
#$testHome/version1/generics/Example00.java -heu -xml -file Generics00_V0_V1
#-dir $testHome/resultsFiles/generics

v1src=$DEVALSUB/voldemortE/scenario1/source1/src
v0src=$DEVALSUB/voldemortE/scenario1/base/src
xmldir=$DEVALSUB/voldemortE/scenario1/config1/source1/astdiff

cd $v1src
#ls -R | grep '\.java'
#find . | grep '\.java'

for fname in $(find . | grep '\.java')
do
    v1fname=${fname/./$v1src}
    v0fname=${fname/./$v0src}
    xmlname=${fname/.\//}
    xmlname=${xmlname//\//.}
    xmlname=${xmlname/%.java/}
    
    java -cp $testHome/tools:$testHome/tools/tools.jar cse.unl.edu.ast.ASTDiffer -original $v0fname -modified $v1fname -heu -xml -file $xmlname -dir $xmldir
done
