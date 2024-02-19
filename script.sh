#!/bin/bash

echo "Bienvenido! Introduce tu nombre"
read nombre
clear
figlet "Hola"
nombre_ascii=$(figlet "$nombre")
echo "$nombre_ascii"
figlet "!"

# Función para mostrar el menú principal
mostrar_menu_principal() {
    while true; do
        echo "==============================="
        echo "============ MENÚ ============="
        echo "==============================="
        PS3="Selecciona una opción: "
        opciones=("Crear Carpeta" "Zoo" "Crear Fichero" "Ingresar Texto" "Salir")
        select opcion in "${opciones[@]}"; do
            case $REPLY in
                1)
                    echo "Elige el nombre de tu nueva carpeta: "
                    ls
                    read carpeta
                    if [ -d "$carpeta" ]; then
                        echo "Esa carpeta ya existe. Inténtalo de nuevo con otro nombre."
                    else
                        mkdir "$carpeta"
                        cd "$carpeta"
                        echo "¡Tu carpeta fue creada exitosamente!"
                        pwd
                        echo ""
                        cd ..
                    fi
                    ;;
                2)
                    mostrar_menu_secundario
                    ;;
                3)
                    echo "Selecciona en qué carpeta deseas crear un fichero: "
                    ls
                    read carpetadestino
                    if [ ! -d "$carpetadestino" ]; then
                        echo "Carpeta no encontrada. Inténtalo de nuevo."
                        continue
                    fi
                    cd "./$carpetadestino" || continue
                    pwd
                    echo "¿Qué nombre deseas ponerle a tu fichero?"
                    read nombrefichero
                    if [ -f "$nombrefichero" ]; then
                        echo "Ese fichero ya existe. Inténtalo de nuevo con otro nombre."
                    else
                        touch "$nombrefichero"
                        echo "¡Tu fichero fue creado exitosamente!"
                        pwd
                        echo ""
                        cd ..
                    fi
                    ;;
                4)
                    echo "Selecciona en qué carpeta se encuentra el fichero: "
                    ls
                    read carpetadestino
                    if [ ! -d "$carpetadestino" ]; then
                        echo "Carpeta no encontrada. Inténtalo de nuevo."
                        continue
                    fi
                    cd "./$carpetadestino" || continue
                    echo "Selecciona el fichero en el que deseas escribir: "
                    ls
                    read ficherodestino
                    if [ ! -f "$ficherodestino" ]; then
                        echo "Fichero no encontrado. Inténtalo de nuevo."
                        cd ..
                        continue
                    fi
                    echo "Escribe libremente: "
                    read -r texto
                    echo "$texto" >> "$ficherodestino"
                    echo "Este fue el texto que has introducido!: "
                    cat "$ficherodestino"
                    cd ..
                    echo "                     "
                    ;;
                5)
                    clear
                    figlet  "Adios"
                    echo "$nombre_ascii"
                    figlet "!"
                    exit
                    ;;
                *)
                    echo "Esta no es una opción válida";;
            esac
            break
        done
    done
}

# Función para mostrar el menú secundario (zoo)
mostrar_menu_secundario() {
    echo ""
    echo "==============================="
    echo ""
    PS3="Escoge un opción: "
    opciones_secundarias=("Invocar un animal" "Mostrar acuario" "Generar frase al azar" "Volver atrás")
    select opcion_secundarias in "${opciones_secundarias[@]}"; do
        case $REPLY in
            1)
                mostrar_menu_terciario
                ;;
            2)
                asciiquarium
                ;; 
                
            3)
                fortune | cowsay | lolcat
                ;;
            4)
                mostrar_menu_principal
                ;;
            *)
                echo "Esta no es una opción válida";;
        esac
    done
}

# Función para mostrar el menú terciario (escoger un animal)
mostrar_menu_terciario() {
    echo ""
    echo "==============================="
    echo ""
    PS3="Escoge un animal: "
    opciones_terciarias=("Dragón" "Vaca" "Pingüino" "Dinosaurio" "Volver atrás")
    select opcion_terciarias in "${opciones_terciarias[@]}"; do
        case $REPLY in
            1)
                echo "Qué mensaje quieres mostrar? "
                read mensaje
                cowsay -f dragon "$mensaje" | lolcat
                ;;
            2)
                echo "Qué mensaje quieres mostrar?:"
                read mensaje
                cowsay "$mensaje" | lolcat
                ;;
            3)
                echo "Qué mensaje quieres mostrar?:"
                read mensaje
                cowsay -f tux "$mensaje" | lolcat
                ;;
            4)
                echo "Qué mensaje quieres mostrar?:"
                read mensaje
                cowsay -f stegosaurus "$mensaje" | lolcat
                ;;
            5)
                mostrar_menu_secundario
                ;;
            *)
                echo "Esta no es una opción válida";;
        esac
    done
}

# Llama a la función del menú principal para iniciar el script.
mostrar_menu_principal
