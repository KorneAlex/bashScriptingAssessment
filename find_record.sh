#!/bin/bash

file=$1
id_check='^[0-9]{5}+$'
abc_check='^[A-Za-z]+([[:space:]|_][A-Za-z]+)*$'

case $2 in

    menu)
        exit_f=0
        while [ $exit_f -eq 0 ]
        do
        echo "============================================================================================="
        echo "||                                       Find record                                       ||"
        echo "============================================================================================="
        echo "|| 1. By ID                                                                                ||"
        echo "|| 2. By name                                                                              ||"
        echo "|| 3. By occupation                                                                        ||"
        echo "|| 4. By depatrament                                                                       ||"
        echo "|| 0. Go back                                                                              ||"
        echo "||                                                                                         ||"
        echo "|| :c to cancel at any time                                                                ||"
        echo "============================================================================================="
        echo -n ":: "
        read option
        case $option in

        1)
            ./find_record.sh $1 by_id
            exit 0
        ;;
        
        2)
            ./find_record.sh $1 by_name
            exit 0
        ;;

        3)
            ./find_record.sh $1 by_occupation
            exit 0
        ;;

        4)
            ./find_record.sh $1 by_departament
            exit 0
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
        foundLineNumber=`awk '{print $2}' $1 | grep -n ^$name$ | awsed -n "$foundLineNumber p" $1k -F: '{print $1}'`
        ! [ -z $foundLineNumber ] && sed -n "$foundLineNumber p" $1 || exit 1
    ;;

    by_id)
        clear
            exit_f2=0
            error_counter=0
            while [ $exit_f2 -eq 0 ]
            do
            if [ $error_counter -ge 3 ];
            then
            clear
            echo "Error. The id should be a number and 5 didgits long x$error_counter"
            echo "To cancel enter :c"
            elif [ $error_counter -gt 0 ];
            then
            clear
            echo "Error. The id should be a number and 5 didgits long x$error_counter"
            fi
            echo "============================================================================================="
            echo "||                                   Find record by ID                                     ||"
            echo "============================================================================================="
            echo "|| :c to cancel at any time                                                                ||"
            echo "============================================================================================="
            echo -n "Please enter the id: "
            read user_input
            if [[ "$user_input" = ":c" ]] ;
            then
                clear
                echo "*** Search canceled ***"
                exit_f2=1
            elif [[ $user_input =~ $id_check ]] ; 
            then
                echo "searching..."
                number_of_lines=`awk '{print $1}' $file | grep $user_input | wc -l` # how many found
                if [ $number_of_lines != 0 ]; 
                then
                    clear
                    #grep $user_input $file >> .temp_search
                    #https://stackoverflow.com/questions/15190838/remove-lines-that-match-column-condition-in-unix-bash
                    echo `awk '$1 == '$user_input' { print $0 }' $file` > .temp_search
                    # https://stackoverflow.com/questions/49110/how-do-i-write-a-for-loop-in-bash
                    format="%s %-5s %3s %-20s %3s %-20s %3s %-15s %3s %-7s %s \n %-s \n"
                    echo "============================================================================================="
                    echo "||                                      Found by id                                        ||"
                    echo "============================================================================================="
                    printf "$format" "||" "ID" "|" "Name" "|" "Ocupation" "|" "Departament" "|" "Wages" "||" "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
                    counter=1
                    cat .temp_search | 
                    while read line
                        do
                            sed ''$counter'!d' .temp_search | 
                            awk '{printf "%s %-5s %3s %-20s %3s %-20s %3s %-15s %3s %-7s %s \n", "||", $1, "|", $2,"|", $3,"|", $4,"|", $5, "||"}'
                        # sed -i -e ''$i's/^/'$i') /' .temp_search # -i to update the file / ^ prefix
                        ((counter++))
                        done
                    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                    # cat .temp_search
                    rm .temp_search
                    exit_f2=1
                else
                    clear
                    echo "*** No results ***"
                fi
            else
                ((error_counter++))
            fi
            done
    ;;

    by_name)
        clear
            exit_f2=0
            error_counter=0
            while [ $exit_f2 -eq 0 ]
            do
            if [ $error_counter -ge 3 ];
            then
            clear
            echo "Error! Warning: Name cannot be blank and must consist of letters a-z x$error_counter"
            echo "To cancel enter :c"
            elif [ $error_counter -gt 0 ];
            then
            clear
            echo "Error! Warning: Name cannot be blank and must consist of letters a-z x$error_counter"
            fi
            echo "============================================================================================="
            echo "||                                  Find record by name                                    ||"
            echo "============================================================================================="
            echo "|| :c to cancel at any time                                                                ||"
            echo "============================================================================================="
            echo -n "Please enter the name: "
            read user_input
            user_input=`echo $user_input | sed 's/ /_/g'` 
            if [[ "$user_input" = ":c" ]] ;
            then
                clear
                echo "*** Search canceled ***"
                exit_f2=1
            elif [[ $user_input =~ $abc_check ]] ; 
            then
                echo "searching..."
                number_of_lines=`awk -v u="$user_input" '$2 ~ u { print }' "$file" | wc -l` # how many found
                if [ $number_of_lines != 0 ]; 
                then
                    clear
                    # Here was my version before I asked AI how to do it better: 
                    # for line in `awk '{ print $2 }' $file | grep -n "" | grep -i $user_input | awk -F: '{print $1}'`;
                    # do 
                    # sed -n "$line p" $1 >> .temp_search
                    # done
                    # cat .temp_search
                    awk -v u="$user_input" '$2 ~ u { print }' "$file" > .temp_search
                    format="%s %-5s %3s %-20s %3s %-20s %3s %-15s %3s %-7s %s \n %-s \n"
                    echo "============================================================================================="
                    echo "||                                    Found by name                                        ||"
                    echo "============================================================================================="
                    printf "$format" "||" "ID" "|" "Name" "|" "Ocupation" "|" "Departament" "|" "Wages" "||" "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
                    counter=1
                    cat .temp_search | 
                    while read line
                        do
                            sed ''$counter'!d' .temp_search | 
                            awk '{printf "%s %-5s %3s %-20s %3s %-20s %3s %-15s %3s %-7s %s \n", "||", $1, "|", $2,"|", $3,"|", $4,"|", $5, "||"}'
                        # sed -i -e ''$i's/^/'$i') /' .temp_search # -i to update the file / ^ prefix
                        ((counter++))
                        done
                    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                    # cat .temp_search
                    rm .temp_search
                    exit 0
                else
                    clear
                    echo "*** No results ***"
                fi
            else
                ((error_counter++))
            fi
            exit 0
            done
            exit 0
    ;;

    by_occupation)
        clear
            exit_f2=0
            error_counter=0
            while [ $exit_f2 -eq 0 ]
            do
            if [ $error_counter -ge 3 ];
            then
            clear
            echo "Error! Warning: Occupation cannot be blank and must consist of letters a-z x$error_counter"
            echo "To cancel enter :c"
            elif [ $error_counter -gt 0 ];
            then
            clear
            echo "Error! Warning: Occupation cannot be blank and must consist of letters a-z x$error_counter"
            fi
            echo "============================================================================================="
            echo "||                               Find record by occupation                                 ||"
            echo "============================================================================================="
            echo "|| :c to cancel at any time                                                                ||"
            echo "============================================================================================="
            echo -n "Please enter the occupation: "
            read user_input
            user_input=`echo $user_input | sed 's/ /_/g'` 
            if [[ "$user_input" = ":c" ]] ;
            then
                clear
                echo "*** Search canceled ***"
                exit_f2=1
            elif [[ $user_input =~ $abc_check ]] ; 
            then
                echo "searching..."
                number_of_lines=`awk -v u="$user_input" '$3 ~ u { print }' "$file" | wc -l` # how many found
                if [ $number_of_lines != 0 ]; 
                then
                    clear
                    awk -v u="$user_input" '$3 ~ u { print }' "$file" > .temp_search
                    format="%s %-5s %3s %-20s %3s %-20s %3s %-15s %3s %-7s %s \n %-s \n"
                    echo "============================================================================================="
                    echo "||                                   Found by occupation                                   ||"
                    echo "============================================================================================="
                    printf "$format" "||" "ID" "|" "Name" "|" "Ocupation" "|" "Departament" "|" "Wages" "||" "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
                    counter=1
                    cat .temp_search | 
                    while read line
                        do
                            sed ''$counter'!d' .temp_search | 
                            awk '{printf "%s %-5s %3s %-20s %3s %-20s %3s %-15s %3s %-7s %s \n", "||", $1, "|", $2,"|", $3,"|", $4,"|", $5, "||"}'
                        ((counter++))
                        done
                    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                    rm .temp_search
                    exit_f2=1
                else
                    clear
                    echo "*** No results ***"
                fi
            else
                ((error_counter++))
            fi
            done
    ;;

    by_departament)
        clear
            exit_f2=0
            error_counter=0
            while [ $exit_f2 -eq 0 ]
            do
            if [ $error_counter -ge 3 ];
            then
            clear
            echo "Error! Warning: Departament cannot be blank and must consist of letters a-z x$error_counter"
            echo "To cancel enter :c"
            elif [ $error_counter -gt 0 ];
            then
            clear
            echo "Error! Warning: Departament cannot be blank and must consist of letters a-z x$error_counter"
            fi
            echo "============================================================================================="
            echo "||                               Find record by departament                                ||"
            echo "============================================================================================="
            echo "|| :c to cancel at any time                                                                ||"
            echo "============================================================================================="
            echo -n "Please enter the departament: "
            read user_input
            user_input=`echo $user_input | sed 's/ /_/g'` 
            if [[ "$user_input" = ":c" ]] ;
            then
                clear
                echo "*** Search canceled ***"
                exit_f2=1
            elif [[ $user_input =~ $abc_check ]] ; 
            then
                echo "searching..."
                number_of_lines=`awk -v u="$user_input" '$4 ~ u { print }' "$file" | wc -l` # how many found
                if [ $number_of_lines != 0 ]; 
                then
                    clear
                    awk -v u="$user_input" '$4 ~ u { print }' "$file" > .temp_search
                    format="%s %-5s %3s %-20s %3s %-20s %3s %-15s %3s %-7s %s \n %-s \n"
                    echo "============================================================================================="
                    echo "||                                  Found by departament                                   ||"
                    echo "============================================================================================="
                    printf "$format" "||" "ID" "|" "Name" "|" "Ocupation" "|" "Departament" "|" "Wages" "||" "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
                    counter=1
                    cat .temp_search | 
                    while read line
                        do
                            sed ''$counter'!d' .temp_search | 
                            awk '{printf "%s %-5s %3s %-20s %3s %-20s %3s %-15s %3s %-7s %s \n", "||", $1, "|", $2,"|", $3,"|", $4,"|", $5, "||"}'
                        ((counter++))
                        done
                    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                    rm .temp_search
                    exit_f2=1
                else
                    clear
                    echo "*** No results ***"
                fi
            else
                ((error_counter++))
            fi
            done
    ;;


    *)
    ;;
esac