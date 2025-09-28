#!/bin/bash

echo "Enter the record id you want to delete or ? to find the record by name:"
echo -n ":: "

# https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
re='^[0-9]+$'
while [ true ]
do
read answer
    if [[ $answer =~ $re && `grep $answer $1` ]] ; then
        foundLineNumber=`./find_record.sh $1 line_number $answer`
        echo "Are you sure you want to delete this record(y/N)?"
        echo ""
        sed -n "$foundLineNumber p" $1  | 
                    awk 'BEGIN  {printf "%s %-5s %3s %-20s %3s %-10s %3s %-11s %3s %-7s %s \n %-s \n", "||", "ID", "|", "Name","|", "Ocupation", "|", "Departament", "|", "Wages", "||", "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"}
                            {printf "%s %-5s %3s %-20s %3s %-10s %3s %-11s %3s %-7s %s \n", "||", $1, "|", $2,"|", $3,"|", $4,"|", $5, "||"}
                    END     {print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"}'
        echo -n ":: "


        while [ true ]
        do
        read answer
            case $answer in
                [yY] | [yY][eE][sS])
                    sed -i -e "$foundLineNumber d" $1 > /dev/null
                    echo "***the user has been successfully deleted***"
                    exit 0
                    ;;
                [nN] | [nN][oO] | *)
                    echo "***Deletion canceled***"
                    exit 0
                    ;;
            esac
        done
        exit 0
    elif [[ "$answer" = "?" ]] ; then
        echo "Sorry, the feature is under development"
        echo "Please enter an number or ? to find the id by name"
        echo -n ":: "
        else 
        echo "Please enter an number or ? to find the id by name"
        echo -n ":: "
    fi
done
