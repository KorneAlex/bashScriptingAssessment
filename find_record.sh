#!/bin/bash

case $2 in

    # find line number by id
    line_number)
        id=$3
        foundLineNumber=`awk '{print $1}' $1 | grep -n ^$id$ | awk -F: '{print $1}'`
        ! [ -z $foundLineNumber ] && echo $foundLineNumber || exit 1
    ;;

    # by id
    id_exist)
        id=$3
        foundId=`awk '{print $1}' $1 | grep -n ^$id$`
        echo $foundId
    ;;

    # by name
    name_exist)
        name=$3
        foundName=`awk '{print $2}' $1 | grep -n ^$name$`
        echo $foundName
    ;;

    # display to screen
    raw_data_byId)
        id=$3
        foundLineNumber=`awk '{print $1}' $1 | grep -n ^$id$ | awk -F: '{print $1}'`
        ! [ -z $foundLineNumber ] && sed -n "$foundLineNumber p" $1 || exit 1
    ;;

    raw_data_byName)
        name=$3
        foundLineNumber=`awk '{print $2}' $1 | grep -n ^$name$ | awk -F: '{print $1}'`
        ! [ -z $foundLineNumber ] && sed -n "$foundLineNumber p" $1 || exit 1
    ;;

    *)
    ;;
esac