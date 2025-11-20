#!/bin/bash

if ! [[ -z $1 ]] ;
then
#echo "parameter entered"
    if ! [[ -f $1 ]] ; 
    then
        available_width=$((75 - 4))
        text="Creating $1"
        text_length=${#text}
        max_text_length=60
        if (( $text_length >= $max_text_length )); then
        echo longer
            display_text="${text:0:max_text_length}..."
            text_length=${#display_text}
        else
            display_text="$text..."
            text_length=${#display_text}
        fi
        padding1=$(( (available_width - text_length) / 2 ))
        if (( (available_width - text_length) % 2 != 0 )) ; then
            padding2=$(( padding1++ ));
        else
            padding2=$padding1;
        fi
        echo "==============================================================================="
        echo "||                                  Welcome                                  ||"
        echo "==============================================================================="
        echo "||                                                                           ||"
        echo "||                                                                           ||"
        echo "||                                                                           ||"
        echo "||                                                                           ||"
        printf "|| %*s %*s %*s ||\n" $padding1 "" $text_length "$display_text" $padding2 ""
        echo "||                                                                           ||"
        echo "||                                                                           ||"
        echo "||                                                                           ||"
        echo "||                                                                           ||"
        echo "==============================================================================="
        sleep 5s
        clear
        touch $1;
        file=$1
    else
        file=$1
    fi
else

    echo "==============================================================================="
    echo "||                                  Welcome                                  ||"
    echo "==============================================================================="
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||         No parameters entered. Checking if the employee.txt exist         ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "==============================================================================="
    sleep 1s
    clear
    if [[ -f employee.txt ]] ;
    then
    echo "==============================================================================="
    echo "||                                  Welcome                                  ||"
    echo "==============================================================================="
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                      The employee.txt exist. Opening...                   ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "==============================================================================="
    sleep 1s
    clear
    file="employee.txt" 
    else 
    echo "==============================================================================="
    echo "||                                  Welcome                                  ||"
    echo "==============================================================================="
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||            The file doesn't exist. Creating a new employee.txt...         ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "||                                                                           ||"
    echo "==============================================================================="
    sleep 1s
    clear
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
        echo "|| 0. Go back                                                                ||"
        echo "||                                                                           ||"
        echo "|| :c to cancel at any time                                                  ||"
        echo "==============================================================================="
        echo -n ":: "
        read option
        case $option in

        1)
            exit_f2=0
            while [ $exit_f2 -eq 0 ]
            do
            clear
            echo -n "Please enter the id: "
            read user_input





########
            if [[ "$user_input" = ":c" ]] ; then 
                clear
                echo "*** Search canceled ***"
                exit_f2=1
                elif [[ $user_input =~ $id_check ]]; then
                    echo "searching..."
                    number_of_lines=`grep $user_input $file | wc -l` # how many found
                    grep $user_input $file >> .temp_search
                    # https://stackoverflow.com/questions/49110/how-do-i-write-a-for-loop-in-bash
                    for ((i = 1 ; i < (($number_of_lines+1)) ; i++ )); 
                    do
                        sed -i -e ''$i's/^/'$i') /' .temp_search # -i to update the file / ^ prefix
                    done
                        cat .temp_search
                    sleep 10
                    rm .temp_search
                    while [ true ]
                        do
                        read answer
                        case $answer in
                            [yY] | [yY][eE][sS])
                                # TODO: edit here and add the id_exist check
                                clear
                                echo "***the id has been successfully edited***"
                                # TODO: display result
                                echo ""
                                exit 0
                                ;;
                            [nN] | [nN][oO] | *)
                                clear
                                echo "*** Edit canceled ***"
                                echo ""
                                exit 0
                                ;;
                        esac
                    done
                    error_counter=0
                else
                ((error_counter++))
                echo "id should be a number and 5 didgits long"
            fi
 # STOPPED HERE FIXING THE SEARCH





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
                    
                fi
                    #exit_f2=1
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
            clear
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
        clear
        echo "                        ***invalid input. try again***"
    ;;
    esac
done