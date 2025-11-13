#!/bin/bash
file=$1
id_check='^[0-9]{5}+$'
id_not_found_counter=0
while [ true ]
do
    echo "==============================================================================="
    echo "||                              Edit record menu                             ||"
    echo "==============================================================================="
    echo "||                                                                           ||"
    echo "||  :c To cancel at any moment                                               ||"
    echo "||  :l To see the list                                                       ||"
    echo "||  :? To find the record by name                                            ||"
    echo "||  Note: id is 5 digits long                                                ||"
    echo "||                                                                           ||"
    echo "==============================================================================="
    echo "Enter the record id you want to edit:"
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
                echo "Do you want to edit this record(Y/n)?"
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
                            [yY] | [yY][eE][sS] | *)
                            ### EDIT MENU ###

# STOPPED HERE

                        while [ true ]
                        do
                        
                            echo "==============================================================================="
                            echo "||                    Please chose what you want to edit                     ||"
                            echo "==============================================================================="
                            echo "||                                                                           ||"
                            echo "||  1. Id                                                                    ||"
                            echo "||  2. Name                                                                  ||"
                            echo "||  3. Ocupation                                                             ||"
                            echo "||  4: Departament                                                           ||"
                            echo "||  5: Wages                                                                 ||"
                            echo "||  0: Go back                                                               ||"
                            echo "||                                                                           ||"
                            echo "||  :c To cancel at any moment                                               ||"
                            echo "||                                                                           ||"
                            echo "==============================================================================="
                            echo -n ":: "
                            read answer
                            case $answer in 

                                1)
                                ./edit.sh $file edit_id $foundLineNumber 
                                ;;

                                2)
                                ./edit.sh $file edit_name $foundLineNumber 
                                ;;

                                3)
                                ./edit.sh $file edit_occupation $foundLineNumber 
                                ;;

                                4)
                                ./edit.sh $file edit_departament $foundLineNumber 
                                ;;

                                5)
                                ./edit.sh $file edit_wages $foundLineNumber 
                                ;;

                                0)
                                echo "Go back"
                                clear
                                exit 0
                                ;;

                                :c)
                                clear
                                exit 0
                                ;;

                                *)
                                clear
                                echo "*** Invalid input ***"
                                ;;
                            esac
                        done
                        ./edit.sh $1 edit_name $foundLineNumber
                        exit 0
                        ;;

                    [nN] | [nN][oO])
                        clear
                        echo "*** Edit canceled ***"
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