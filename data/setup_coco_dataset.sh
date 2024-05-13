#!/bin/bash
export BASEDIR=/root/aws/coco

for f in $BASEDIR/images/train2014/*.jpg; do echo "$f" >> train2014.txt; done
for f in $BASEDIR/images/val2014/*.jpg; do echo "$f" >> val2014.txt; done
#ls $PWD/images/train2014/*.jpg > train2014.txt
#ls $PWD/images/val2014/*.jpg > val2014.txt

# Set Up Image Lists
paste <(awk "{print \"$BASEDIR\"}" < $BASEDIR/5k.part) $BASEDIR/5k.part | tr -d '\t' > 5k.txt
paste <(awk "{print \"$BASEDIR\"}" < $BASEDIR/trainvalno5k.part) $BASEDIR/trainvalno5k.part | tr -d '\t' > trainvalno5k.txt
