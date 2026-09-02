
echo "para sair do scripit digite [exit]"

sleep 2
    clear


inicio(){

lista=$(ls ~)
i=1

echo "
============================== pastas home ==============================
"

while read -r item; do
    valor="$i: $item"
    echo "$valor"
    ((i++))
done <<< "$lista"


echo "
======DIGITE: [0] para visualizar quantidade de arquivos ======

ou digite o numero da pasta desejada
"
read -p ": " entrada


case "$entrada" in

    0)
        read -p "Digite o ID da pasta: " ll

        i=1

        while read -r item; do
            if [[ "$ll" == "$i" ]]; then
                caminho="$HOME/$item"
                break
            fi

            ((i++))
        done <<< "$lista"

        if [[ -z "$caminho" || ! -d "$caminho" ]]; then
            echo "ID inválido."
            sleep 2
            return
        fi

        while true; do

            clear

            echo "==============================================="
            echo "Caminho: $caminho"
            echo "==============================================="
            echo

            echo "Quantidade total: $(find "$caminho" -type f | wc -l)"
            echo

            find "$caminho" -type f -printf '%f\n' |
            awk '
            {
                n = split($0, a, ".")
                if (n > 1)
                    print "." a[n]
                else
                    print "[sem extensão]"
            }' |
            sort |
            uniq -c |
            sort -nr

            echo
            read -p "Digite 0 para voltar a home: " voltar

				slep 3 
					clear
					cls
					reset
					
            if [[ "$voltar" == "0" ]]; then
                return
            else
                echo "$voltar"
                sleep 2
            fi

        done
        ;;

esac


ent="${entrada,,}"

if [[ "$ent" == "exit" ]]; then

	exit

  fi	

i=1

while read -r item; do
    if [[ "$entrada" == "$i" ]]; then
       
        caminho="$HOME/$item"
       
        break
    fi

    ((i++))

done <<< "$lista"


clear

echo "============ pastas de $caminho =========="

echo

ls "$caminho"

menu(){

echo "==============================================="
echo "  [1] Ver tamanho   [2] Remover   [3] Voltar"
echo "==============================================="

}

menu

while true; do

	read -p "digite sua opção: " ir

	case "$ir" in


		1)

		
    clear
    menu

    echo "Arquivos do caminho: $caminho"
    echo
    printf "%-35s %-15s %-20s\n" "NOME" "TAMANHO" "CRIAÇÃO"
    echo "-----------------------------------------------------------------------"

    find "$caminho" -type f -print0 |
    while IFS= read -r -d '' arquivo; do
        nome=$(basename "$arquivo")
        tamanho=$(du -h "$arquivo" | cut -f1)
        criacao=$(stat -c '%w' "$arquivo")

        printf "%-35s %-15s %-20s\n" "$nome" "$tamanho" "$criacao"
    done

    ;;	    




     2)
                    clear
                          
               echo "=========== REMOVER ==========="
                          echo
                          
                            i=1
                          
                       while IFS= read -r item; do
                      echo "$i: $item"
                                  ((i++))
                   done < <(find "$caminho" -maxdepth 1 -mindepth 1 -printf '%f\n')
                          
                         echo
                         read -p "Digite o ID do arquivo/pasta: " id
                          
                        i=1
                       alvo=""
                          
                     while IFS= read -r item; do
                            if [[ "$id" == "$i" ]]; then
                              alvo="$caminho/$item"
                         break
                             fi
                          
                      ((i++))
                     done < <(find "$caminho" -maxdepth 1 -mindepth 1 -printf '%f\n')
                          
               if [[ -z "$alvo" || ! -e "$alvo" ]]; then
                         echo "ID inválido."
                          sleep 2
                    continue
                        fi
                          
                        echo
                       echo "Você escolheu: $alvo"
                         echo 
                              read -p "Tem certeza? [y/n]: " r
                          
                              rr="${r,,}"
                          
                              if [[ "$rr" == "y" ]]; then
                                  rm -rf -- "$alvo"
                          
                                  if [[ ! -e "$alvo" ]]; then
                                      echo "Removido com sucesso!"

                                      menu
                                      
                                  else
                                      echo "Erro ao remover."

                                      menu
                                  fi
                              else
                                  echo "Operação cancelada."

                                  menu
                              fi
                          
                              sleep 2
                              ;;



          3)
			    echo "voltando a page ~"
			    sleep 1
			    clear
			    break
			    ;;

	esac
 done

 	

}


while true; do
    inicio
done
