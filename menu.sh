#!/bin/bash

id_check='^[0-9]{5}+$'

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
        echo "============================================================================================="
        echo "||                                         Welcome                                         ||"
        echo "============================================================================================="
        echo "||                                                                                         ||"
        echo "||                                                                                         ||"
        echo "||                                                                                         ||"
        echo "||                                                                                         ||"
        printf "|| %*s %*s %*s ||\n" $padding1 "" $text_length "$display_text" $padding2 ""
        echo "||                                                                                         ||"
        echo "||                                                                                         ||"
        echo "||                                                                                         ||"
        echo "||                                                                                         ||"
        echo "============================================================================================="
        sleep 5s
        clear
        touch $1;
        file=$1
    else
        file=$1
    fi
else

    echo "============================================================================================="
    echo "||                                         Welcome                                         ||"
    echo "============================================================================================="
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                No parameters entered. Checking if the employee.txt exist                ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "============================================================================================="
    sleep 1s
    clear
    if [[ -f employee.txt ]] ;
    then
    echo "============================================================================================="
    echo "||                                         Welcome                                         ||"
    echo "============================================================================================="
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                             The employee.txt exist. Opening...                          ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "============================================================================================="
    sleep 1s
    clear
    file="employee.txt" 
    else 
    echo "============================================================================================="
    echo "||                                         Welcome                                         ||"
    echo "============================================================================================="
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                   The file doesn't exist. Creating a new employee.txt...                ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "||                                                                                         ||"
    echo "============================================================================================="
    sleep 1s
    clear
    touch employee.txt
    file="employee.txt"
fi
fi
while [ true ]
do
    echo "============================================================================================="
    echo "||                                          Menu                                           ||"
    echo "============================================================================================="
    echo "||                                                                                         ||"
    echo "|| 1. List all records                                                                     ||"
    echo "|| 2. Create new record                                                                    ||"
    echo "|| 3. Edit record                                                                          ||"
    echo "|| 4. Delete record                                                                        ||"
    echo "|| 5. Find record by ...                                                                   ||"
    echo "|| 0. Exit                                                                                 ||"
    echo "||                                                                                         ||"
    echo "============================================================================================="
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
        clear
        ./find_record.sh $file menu
    ;;

    0)
echo "                                          ***Bye-bye***"
        exit 0
    ;;

    *)
        clear
        echo -e "                               ${RED}*** Invalid input. Try again ***${RESET}"
    ;;
    esac
done