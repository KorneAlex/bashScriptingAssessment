#!/bin/bash
clear
# https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
id_check='^[0-9]{5}+$'
id_not_found_counter=0
file=$1
while [ true ]
do
       
        echo "==============================================================================="
        echo "||                            Delete record menu                             ||"
        echo "==============================================================================="
        echo "||  :c To cancel at any moment                                               ||"
        echo "||  :l To see the list                                                       ||"
        echo "||  :? To find the record by name                                            ||"
        echo "||  Note: id is 5 digits long                                                ||"
        echo "==============================================================================="
        echo ""
echo "Enter the record id you want to delete:"
echo -n ":: "
read answer
    if [[ "$answer" = ":c" ]] ;
        then 
        exit 0
        elif [[ "$answer" = ":l" ]] ;
        then 
        clear
        ./list.sh $file
        elif [[ $answer =~ $id_check && `grep $answer $1` ]] ; 
            then
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
                        clear
                        echo "***the user has been successfully deleted***"
                        echo ""
                        exit 0
                        ;;
                    [nN] | [nN][oO] | *)
                        clear
                        echo "***Deletion canceled***"
                        echo ""
                        exit 0
                        ;;
                esac
            done
            exit 0
        elif [[ "$answer" = "?" ]] ; then
            clear
            echo "Sorry, the feature is under development"
            else 
            clear
            echo -n "The entered id is not found "
            if ! [ $id_not_found_counter = 0 ]; then
                echo "x$id_not_found_counter"
                ((id_not_found_counter++))
                else
                echo ""
                ((id_not_found_counter++))
                fi
    fi
done
