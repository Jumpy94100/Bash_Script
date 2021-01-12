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

Installation_Dependances() {
    echo "Installation des dependances ⏳⏳"
    Error_Message=$(sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "Installation effectuée ✅✅"
    else
        echo ${Error_Message}
        exit 0
    fi
}

Ajout_GPG_Et_Repository() {
    echo "Ajout de la clé GPG Docker ⏳⏳"
    Error_Message_GPG=$(curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "Clé GPG ajoutée ✅✅"

        echo "Ajout Repository ⏳⏳"
        Error_Message_Repository=$(sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" 2>&1)

        if [[ $? -eq 0 ]]; then
            echo "Repositry ajouté ✅✅"
        else
            echo ${Error_Message_GPG}
            exit 0
        fi
    else
        echo ${Error_Message_GPG}
        exit 0
    fi
}

Installation_Docker() {
    echo "Installation Docker packages ⏳⏳"
    Error_Message=$(sudo apt-get install docker-ce docker-ce-cli containerd.io -y 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "Installation effectuée ✅✅"
        echo ""
    else
        echo ${Error_Message}
        exit 0
    fi

}

Docker_Run_Hello_World() {
    echo "Lancement Conteneur Hello World ⏳⏳"
    Error_Message=$(sudo docker run hello-world)

    if [[ $? -eq 0 ]]; then
        echo "Installation effectuée ✅✅"
        echo ""
    else
        echo ${Error_Message}
        exit 0
    fi
}

main() {
    Update_APT
    Installation_Dependances
    Ajout_GPG_Et_Repository
    Update_APT
    Installation_Docker
    Docker_Run_Hello_World
}

main
