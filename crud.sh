#!/bin/bash





#find by id
read id
foundLineNumber=`awk '{print $1}' $1 | grep -n ^$id$ | awk -F: '{print $1}'`
[ ! -z $foundLineNumber ] && echo found; status=0 || echo "not found"; status=1
echo "line to delete: " $foundLineNumber
sed -n "$foundLineNumber p" $1 > /dev/null

#delete
sed -e "$foundLineNumber d" $1
