#!/bin/bash

Update_APT() {
    echo "Lancement d'APT Update ⏳⏳"
    Error_Message=$(sudo apt-get update 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "Apt Update effectué ✅✅"
    else
        echo ${Error_Message}
        exit 0
    fi
}

Download_Docker_Compose() {
    echo "Téléchargement de Docker Compose ⏳⏳"
    Error_Message=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-Linux-x86_64 | cut -d '"' -f 4 | grep -v ".sha256" | wget -qi - 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "Téléchargement effectué ✅✅"
    else
        echo ${Error_Message}
        exit 0
    fi
}

Change_Permission_And_Move() {
    echo "Changement de permission ⏳⏳"
    Error_Message_Permission=$(sudo chmod +x docker-compose-Linux-x86_64 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "Changement de permission effectué ✅✅"
        echo "Déplacemment du fichier ⏳⏳"
        Error_Message_Move=$(sudo mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose 2>&1)

        if [[ $? -eq 0 ]]; then
            echo "Déplacement effectué ✅✅"
        else
            echo ${Error_Message_Move}
            exit 0
        fi
    else
        echo ${Error_Message_Permission}
        exit 0
    fi

}

Check_Docker_Compose_Version() {
    echo "Vérification de la version de Docker Compose ⏳⏳"
    sudo docker-compose version
}

main () {
    Update_APT
    Download_Docker_Compose
    Change_Permission_And_Move
    Check_Docker_Compose_Version
}

main
