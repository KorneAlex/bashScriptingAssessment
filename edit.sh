#!/bin/bash

file=$1
foundLineNumber=$2

echo $1
echo $2
echo $3

case $2 in

    # find line number by id
    edit_id)
        id=$3
        foundLineNumber=`awk '{print $1}' $1 | grep -n ^$id$ | awk -F: '{print $1}'`
        ! [ -z $foundLineNumber ] && echo $foundLineNumber || exit 1
    ;;

    # by id
    edit_name)
        echo NAME
    ;;

    # by name
    edit_occupation)
        name=$3
        foundName=`awk '{print $2}' $1 | grep -n ^$name$`
        echo $foundName
    ;;

    # display to screen
    edit_departament)
        id=$3
        foundLineNumber=`awk '{print $1}' $1 | grep -n ^$id$ | awk -F: '{print $1}'`
        ! [ -z $foundLineNumber ] && sed -n "$foundLineNumber p" $1 || exit 1
    ;;

    edit_wages)
        name=$3
        foundLineNumber=`awk '{print $2}' $1 | grep -n ^$name$ | awk -F: '{print $1}'`
        ! [ -z $foundLineNumber ] && sed -n "$foundLineNumber p" $1 || exit 1
    ;;

    *)
    ;;
esac