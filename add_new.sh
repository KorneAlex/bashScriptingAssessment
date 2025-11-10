#!/bin/bash

count=0
re='^[0-9]+$'
id_check='^[0-9]{5}+$'
re2='^[0-9]+([.][0-9]+)?$'
abc_check='^[A-Za-z]+([[:space:]][A-Za-z]+)*$'
        clear
        echo "==============================================================================="
        echo "||                          Enter new record menu                            ||"
        echo "==============================================================================="
        echo "||  To cancel at any moment, please type :c                                  ||"
        echo "||  All spaces will be replaced with \"_\"                                     ||"
        echo "==============================================================================="
        echo ""

while [ $count -lt 5 ]
do 
    if [ $count -eq 0 ]
    then
        echo -n "Please enter the id (5 digit number): "
        read id
        if [[ "$id" = ":c" ]] ;
        then 
        exit 0
        # elif `awk 'match($1,/^33$/)' $1 | awk '{print $1}'`
        elif ! [ -z "${id}" ] && [[ $id =~ $id_check ]] && ! [ -n "`awk 'match($1, '$id')' $1`" ] ; # tried everythig until it worked
        then
            count=$((count+1))
        else 
            echo "Warning: This id is already exist or input is invalid. Please enter a number"
        fi
    elif [ $count -eq 1 ]
    then
        echo -n "Please enter the employees' full name: "
        read name
        if [[ "$name" = ":c" ]] ;
        then 
        exit 0
        elif ! [ -z "${name}" ] && [[ $name =~ $abc_check ]] ;
        then
            name=`echo $name | sed 's/ /_/g'`  # replace ALL spaces with "_"
            count=$((count+1))
        else 
            echo "Error! Warning: Name cannot be blank and must consist of letters a-z"
        fi
    elif [ $count -eq 2 ]
    then
        echo -n "Please enter the occupation: "
        read occupation
        if [[ "$occupation" = ":c" ]] ;
        then 
        exit 0
        elif ! [ -z "${occupation}" ]
        then
            occupation=`echo $occupation | sed 's/ /_/g'` 
            count=$((count+1))
        else 
            echo "Warning: Occupation cannot be blank"
        fi
    elif [ $count -eq 3 ]
    then
        echo -n "Please enter the departament: "
        read departament
        if [[ "$departament" = ":c" ]] ;
        then 
        exit 0
        elif ! [ -z "${departament}" ]
        then
            departament=`echo $departament | sed 's/ /_/g'` 
            count=$((count+1))
        else 
            echo "Warning: Departament cannot be blank"
        fi
    else
        echo -n "Please enter the wages (amount in euro): "
        read wages
        if [[ "$wages" = ":c" ]] ;
        then 
        exit 0
        elif ! [ -z "${wages}" ] && [[ $wages =~ $re2 ]]
        then
            count=$((count+1))
        else 
            echo "Warning: Wages should be a number"
        fi
    fi
done
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Do you want to add this record(Y/n)?:"
echo "--> "$id" "$name" "$occupation" "$departament" €"$wages" <--"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -n ":: "
exit_a=0
while [ $exit_a = 0 ]
do
read answer
    case $answer in
        [yY] | [yY][eE][sS] | "")
            echo $id" "$name" "$occupation" "$departament" €"$wages >> $1
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

# TODO fix user input (spaces)