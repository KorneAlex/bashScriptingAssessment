#!/bin/bash

if ! [[ -z $1 ]] ;
then
#echo "parameter entered"
    if ! [[ -f $1 ]] ; 
    then
        echo "creating " $1; 
        touch $1;
        file=$1
    else
        file=$1
    fi
else
    echo "No parameters entered. Checking if the employee.txt exist"
    if [[ -f employee.txt ]] ;
    then
    echo "The employee.txt exist. Opening..." 
    file="employee.txt" 
    else 
    echo "The file doesn't exist. Creating a new employee.txt"
    touch employee.txt
    file="employee.txt"
fi
fi
while [ true ]
do
    echo "==============================================================================="
    echo "||                                     Menu                                  ||"
    echo "==============================================================================="
    echo "||                                                                           ||"
    echo "|| 1. List all records                                                       ||"
    echo "|| 2. Create new record                                                      ||"
    echo "|| 3. Edit record                                                            ||"
    echo "|| 4. Delete record                                                          ||"
    echo "|| 5. Find record by ...                                                     ||"
    echo "|| 0. Exit                                                                   ||"
    echo "||                                                                           ||"
    echo "==============================================================================="
    echo -n ":: "
    read option
    case $option in

    1)
        clear
        ./list.sh $file
    ;;
    2)
        clear
        ./add_new.sh $file
    ;;

    3)
        clear
        ./edit_record.sh $file
    ;;

    4)
        clear
        ./delete_record.sh $file
    ;;

    5)
        exit_f=0
        while [ $exit_f -eq 0 ]
        do
        echo "==============================================================================="
        echo "||                                 Find record                               ||"
        echo "==============================================================================="
        echo "|| 1. By ID                                                                  ||"
        echo "|| 2. By name (exact match)                                                  ||"
        echo "|| 0. Exit                                                                   ||"
        echo "==============================================================================="
        echo -n ":: "
        read option
        case $option in

        1)
            exit_f2=0
            while [ $exit_f2 -eq 0 ]
            do
            read user_input
            checkId=`./find_record.sh $file id_exist $user_input`
            echo $checkId
                if ! [[ -z $checkId ]] ;
                then
                    echo `./find_record.sh $file raw_data_byId $user_input` | 
                    awk 'BEGIN  {printf "%s %-5s %3s %-20s %3s %-10s %3s %-11s %3s %-7s %s \n %-s \n", "||", "ID", "|", "Name","|", "Ocupation", "|", "Departament", "|", "Wages", "||", "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"}
                            {printf "%s %-5s %3s %-20s %3s %-10s %3s %-11s %3s %-7s %s \n", "||", $1, "|", $2,"|", $3,"|", $4,"|", $5, "||"}
                    END     {print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"}'
                    exit_f2=1
                else
                    echo "User not found"
                    exit_f2=1
                fi
            done
        ;;
        
        2)
            exit_f2=0
            while [ $exit_f2 -eq 0 ]
            do
            read user_input
            checkName=`./find_record.sh $file name_exist $user_input`
                if ! [[ -z $checkName ]] ;
                then
                    echo `./find_record.sh $file raw_data_byName $user_input` | 
                    awk 'BEGIN  {printf "%s %-5s %3s %-20s %3s %-10s %3s %-11s %3s %-7s %s \n %-s \n", "||", "ID", "|", "Name","|", "Ocupation", "|", "Departament", "|", "Wages", "||", "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"}
                            {printf "%s %-5s %3s %-20s %3s %-10s %3s %-11s %3s %-7s %s \n", "||", $1, "|", $2,"|", $3,"|", $4,"|", $5, "||"}
                    END     {print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"}'
                    exit_f2=1
                else
                    echo "User not found"
                    exit_f2=1
                fi
            done
        ;;

        0)
            exit_f=1
        ;;

        *)
                echo "                        ***invalid input. try again***"
        ;;

        esac
        done
    ;;

    0)
echo "                                   ***Bye-bye***"
        exit 0
    ;;

    *)
        echo "                        ***invalid input. try again***"
    ;;
    esac
done