#!/bin/bash

count=0
while [ $count -lt 4 ]
do 
    if [ $count -eq 0 ]
    then
        echo -n "Please enter the id: "
        read id
        if ! [ -z "${id}" ]
        then
            count=$((count+1))
        else 
            echo "Warning: Id cannot be blank"
        fi
    elif [ $count -eq 1 ]
    then
        echo -n "Please enter the name: "
        read name
        if ! [ -z "${name}" ]
        then
            count=$((count+1))
        else 
            echo "Warning: Name cannot be blank"
        fi
    elif [ $count -eq 2 ]
    then
        echo -n "Please enter the occupation: "
        read occupation
        if ! [ -z "${occupation}" ]
        then
            count=$((count+1))
        else 
            echo "Warning: Occupation cannot be blank"
        fi
    elif [ $count -eq 3 ]
    then
        echo -n "Please enter the departament: "
        read departament
        if ! [ -z "${departament}" ]
        then
            count=$((count+1))
        else 
            echo "Warning: Departament cannot be blank"
        fi
    else
        echo -n "Please enter the wages: "
        read wages
        if ! [ -z "${wages}" ]
        then
            count=$((count+1))
        else 
            echo "Warning: Wages cannot be blank"
        fi
    fi
done
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Do you want to add this record(Y/n)?:"
echo "--> "$id" "$name" "$occupation" "$departament" "$wages" <--"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -n ":: "
exit_a=0
while [ $exit_a = 0 ]
do
read answer
    case $answer in
        [yY] | [yY][eE][sS] | "")
            echo $id" "$name" "$occupation" "$departament" "$wages >> $1
            echo "***the record has been successfully saved***"
            exit_a=1
            ;;
        [nN] | [nN][oO] )
            echo "***record was not saved***"
            exit_a=1
            ;;
        *) 
            echo "***please, try again***"
            echo -n ":: "
        ;;
    esac
done
echo
echo
echo "Do you want to add another record(y/N)?"
exit_a=0
while [ $exit_a = 0 ]
do
read answer
    case $answer in
    [yY] | [yY][eE][sS] )
        ./add_new.sh $1
    ;;
    *)
    exit_a=1
    ;;
    esac
done