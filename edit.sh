#!/bin/bash

file=$1
foundLineNumber=$3
id_check='^[0-9]{5}+$'
number_check='^[0-9]+$'
abc_check='^[A-Za-z]+([[:space:]][A-Za-z]+)*$'
error_counter=0
echo $1
echo $2
echo $3

case $2 in

#===============================id==============================================================
    edit_id)
        current=`sed -n ''$3'p' $1 | awk '{print $1}'`
        while [ true ]
        do
            clear
            echo "Current id is" $current
            if [ "$error_counter" -ge 3 ]; then
                echo "Error: id should be a number and 5 didgits long"
                echo "Incorrect id x$error_counter To cancel enter :c"
            elif ! [ $error_counter = 0 ]; then
                echo "Error: id should be a number and 5 didgits long"
                echo "Incorrect id x$error_counter"
            fi
            echo -n "Please enter a new id: "
            read new_id
            if [[ "$new_id" = ":c" ]] ;
            then 
            clear
            echo "*** Edit canceled ***"
            exit 0
            elif [[ $new_id =~ $id_check ]]; then
            echo "Confirm id change $current --> $new_id (y/N)?"
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
        done
    ;;
#===============================NAME============================================================
    edit_name)
        current=`sed -n ''$3'p' $1 | awk '{print $2}'`
        while [ true ]
        do
            clear
            echo "Current name is" $current
            if [ "$error_counter" -ge 3 ]; then
                echo "Error: Name should countain letters only and be not longer than 20 chars long"
                echo "Incorrect name x$error_counter To cancel enter :c"
            elif ! [ $error_counter = 0 ]; then
                echo "Error: Name should countain letters only and be not longer than 20 chars long"
                echo "Incorrect name x$error_counter"
            fi
            echo -n "Please enter a new name: "
            read new_name
            if [[ "$new_name" = ":c" ]] ;
            then current=`sed -n '8p' $1 | awk '{print $2}'`
            clear
            echo "*** Edit canceled ***"
            exit 0
            elif [[ $new_name =~ $abc_check && ${#new_name} -ge 2 && ${#new_name} -le 20 ]]; then # ${#...} - length parameter expancion
            echo "Confirm name change $current --> $new_name (y/N)?"
            while [ true ]
                do
                read answer
                case $answer in
                    [yY] | [yY][eE][sS])
                        # TODO: edit here
                        clear
                        echo "***the name has been successfully edited***"
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
            fi
        done
    ;;
#===============================OCCUPATION======================================================
    edit_occupation)
        current=`sed -n ''$3'p' $1 | awk '{print $3}'`
        while [ true ]
        do
            clear
            echo "Current occupation is" $current
            if [ "$error_counter" -ge 3 ]; then
                echo "Error: Occupation should countain letters only and be not longer than 20 chars long"
                echo "Incorrect occupation x$error_counter To cancel enter :c"
            elif ! [ $error_counter = 0 ]; then
                echo "Error: Occupation should countain letters only and be not longer than 20 chars long"
                echo "Incorrect occupation x$error_counter"
            fi
            echo -n "Please enter a new occupation: "
            read new_occupation
            if [[ "$new_occupation" = ":c" ]] ;
            then 
            clear
            echo "*** Edit canceled ***"
            exit 0
            elif [[ $new_occupation =~ $abc_check && ${#new_occupation} -ge 2 && ${#new_occupation} -le 20 ]]; then # ${#...} - length parameter expancion
            echo "Confirm occupation change $current --> $new_occupation (y/N)?"
            while [ true ]
                do
                read answer
                case $answer in
                    [yY] | [yY][eE][sS])
                        # TODO: edit here
                        clear
                        echo "***the occupation has been successfully edited***"
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
            fi
        done
    ;;
#===============================DEPARTAMENT=====================================================
    edit_departament)
        current=`sed -n ''$3'p' $1 | awk '{print $4}'`
        while [ true ]
        do
            clear
            echo "Current departament is" $current
            if [ "$error_counter" -ge 3 ]; then
                echo "Error: Departament should countain letters only and be not longer than 15 chars long"
                echo "Incorrect departament x$error_counter To cancel enter :c"
            elif ! [ $error_counter = 0 ]; then
                echo "Error: Departament should countain letters only and be not longer than 15 chars long"
                echo "Incorrect departament x$error_counter"
            fi
            echo -n "Please enter a new departament: "
            read new_departament
            if [[ "$new_departament" = ":c" ]] ;
            then 
            clear
            echo "*** Edit canceled ***"
            exit 0
            elif [[ $new_departament =~ $abc_check && ${#new_departament} -ge 2 && ${#new_departament} -le 15 ]]; then # ${#...} - length parameter expancion
            echo "Confirm departament change $current --> $new_departament (y/N)?"
            while [ true ]
                do
                read answer
                case $answer in
                    [yY] | [yY][eE][sS])
                        # TODO: edit here
                        clear
                        echo "***the departament has been successfully edited***"
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
            fi
        done
    ;;
#===============================WAGES===========================================================
    edit_wages)
        current=`sed -n ''$3'p' $1 | awk '{print $5}'`
        while [ true ]
        do
            clear
            echo "Current wages: " $current
            if [ "$error_counter" -ge 3 ]; then
                echo "Error: Wages should be a number and no more than 6 didgits long"
                echo "Incorrect wages x$error_counter To cancel enter :c"
            elif ! [ $error_counter = 0 ]; then
                echo "Error: Wages should be a number and no more than 6 didgits long"
                echo "Incorrect wages x$error_counter"
            fi
            echo -n "Please enter a new wages (number only): "
            read new_wages
            if [[ "$new_wages" = ":c" ]] ;
            then 
            clear
            echo "*** Edit canceled ***"
            exit 0
            elif [[ $new_wages =~ $number_check && ${#new_wages} -ge 2 && ${#new_wages} -le 15 ]]; then # ${#...} - length parameter expancion
            echo "Confirm wages change $current --> $new_wages (y/N)?"
            while [ true ]
                do
                read answer
                case $answer in
                    [yY] | [yY][eE][sS])
                        # TODO: edit here
                        clear
                        echo "***the wages has been successfully edited***"
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
            fi
        done
    ;;

    *)
    clear
    echo "*** Invalid input ***"
    ;;
esac