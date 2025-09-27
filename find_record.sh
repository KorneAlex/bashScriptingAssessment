#!/bin/bash

case $2 in

    # by id
    id)
        #echo Please enter the id:
        #echo -n ":: "
        #read id
        id=$3
        foundLineNumber=`awk '{print $1}' $1 | grep -n ^$id$ | awk -F: '{print $1}'`
        ! [ -z $foundLineNumber ] && sed -n "$foundLineNumber p" $1 || exit 1
    ;;

    # by name
    2)
    ;;

    # display to screen and give options
    0)
    ;;

    *)
    ;;
esac