#!/bin/bash

echo "Enter the record id you want to delete or ? to find the record by name:"
echo -n ":: "

# https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
re='^[0-9]+$'
while [ true ]
do
read answer
    if [[ $answer =~ $re ]] ; then
        echo `./find_record.sh $1 id $answer`
        exit 0
    elif [[ "$answer" = "?" ]] ; then
        echo "need to find"
    else 
        echo "Please enter an number or ? to find the id by name"
        echo -n ":: "
    fi
done