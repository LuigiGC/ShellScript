#!/bin/bash

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

BG_GREEN='\033[42m'
BG_RESET='\033[49m'

# Função para capturar Ctrl+C e impedir a interrupção do script
trap_ctrlc() {
    echo -e "\n${RED}Tentativa de utilização do Ctrl+C detectada. A unica forma de sair do programa é utilizando a opção 5 no menu de opções!${RESET}"
}

# Definir a trap para o sinal SIGINT (Ctrl+C)
trap trap_ctrlc SIGINT

# Função para exibir o cabeçalho
mostrar_cabecalho() {
    clear
    largura=58

    BG_GREEN=$(tput setab 2)
    WHITE=$(tput setaf 7)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    RESET=$(tput sgr0)

    printf "%s\n" "${BG_GREEN}${WHITE}##########################################################${RESET}"

    printf "${BG_GREEN}${WHITE}# ${YELLOW}IBMEC"; printf "%*s" $(( largura - 6 - 2 )) ""; printf "${WHITE}#${RESET}\n"
    printf "${BG_GREEN}${WHITE}# ${YELLOW}Sistemas Operacionais${YELLOW}               Semestre 1 de 2024"; printf "%*s" $(( largura - 6 - 51 )) ""; printf "${WHITE}#${RESET}\n"
    printf "${BG_GREEN}${WHITE}# ${YELLOW}Código: IBM8940${YELLOW}                     Turma: 8001"; printf "%*s" $(( largura - 4 - 46 )) ""; printf "${WHITE}#${RESET}\n"
    printf "${BG_GREEN}${WHITE}# ${YELLOW}Professor: Luiz Fernando T. de Farias"; printf "%*s" $(( largura - 6 - 34 )) ""; printf "${WHITE}#${RESET}\n"

    printf "%s\n" "${BG_GREEN}${WHITE}----------------------------------------------------------${RESET}"

    printf "${BG_GREEN}${WHITE}# ${WHITE}Equipe Desenvolvedora:"; printf "%*s" $(( largura - 6 - 19 )) ""; printf "${WHITE}#${RESET}\n"
    printf "${BG_GREEN}${WHITE}# ${BLUE}Aluno: Arthur Camaz"; printf "%*s" $(( largura - 6 - 16 )) ""; printf "${WHITE}#${RESET}\n"
    printf "${BG_GREEN}${WHITE}# ${BLUE}Aluno: Felipe Tavares"; printf "%*s" $(( largura - 6 - 18 )) ""; printf "${WHITE}#${RESET}\n"
    printf "${BG_GREEN}${WHITE}# ${BLUE}Aluno: Luigi Cardoso"; printf "%*s" $(( largura - 6 - 17 )) ""; printf "${WHITE}#${RESET}\n"

    printf "%s\n" "${BG_GREEN}${WHITE}----------------------------------------------------------${RESET}"

    data=$(date +"%d de %B de %Y")
    hora=$(date +"${BLUE}%H ${MAGENTA}Hora(s) e ${BLUE}%M ${MAGENTA}Minuto(s)")
    printf "${BG_GREEN}${WHITE}# ${MAGENTA}Rio de Janeiro, ${data}"; printf "%*s" $(( largura - 6 - 13 - ${#data} )) ""; printf "${WHITE}#${RESET}\n"
    printf "${BG_GREEN}${WHITE}# ${MAGENTA}Hora do Sistema: ${hora}"; printf "%*s" $(( largura - 6 - 20 - ${#hora} )) ""; printf "${WHITE}#${RESET}\n"

    printf "%s\n" "${BG_GREEN}${WHITE}##########################################################${RESET}"
}

# Função para exibir o menu principal
exibir_menu_principal() {
    echo -e "${CYAN}Menu de Escolhas:${RESET}"
    echo -e "${GREEN}1) Gerenciar Contatos${RESET}"
    echo -e "${YELLOW}2) Criar backup dos arquivos${RESET}"
    echo -e "${MAGENTA}3) Calculadora${RESET}"
    echo -e "${BLUE}4) Informações do Sistema${RESET}"
    echo -e "${RED}5) Finalizar o programa${RESET}"
    echo -en "${CYAN}Selecione uma opção: ${RESET}"
}

# Função para processar a escolha do usuário
processar_escolha() {
    case $1 in
        1) gerenciar_contatos ;;
        2) criar_backup ;;
        3) gerenciar_calculadora ;;
        4) informacoes_do_sistema ;;
        5) finalizar ;;
        *) echo -e "${RED}Opção inválida. Tente novamente.${RESET}" ;;
    esac
}

# Função para criar backup dos arquivos
criar_backup() {
    clear
    echo -e "${CYAN}##############################################################${RESET}"
    echo -e "${CYAN}#                      Criar Backup de Arquivos              #${RESET}"         
    echo -e "${CYAN}##############################################################${RESET}"

    echo -e "${YELLOW}Diretórios disponíveis:${RESET}"
    ls -d */
    
    read -p "Informe o diretório que deseja fazer backup: " diretorio
    echo -e "${YELLOW}Arquivos disponíveis no diretório $diretorio:${RESET}"
    ls "$diretorio"
    
    read -p "Informe o nome do arquivo de backup (sem extensão): " nome_backup
    tar -czvf "$nome_backup.tar.gz" "$diretorio"
    echo -e "${GREEN}Backup criado com sucesso: $nome_backup.tar.gz${RESET}"
}

# Função para exibir o menu de gerenciamento de contatos
exibir_menu_contatos() {
    clear
    echo -e "${CYAN}##############################################################${RESET}"
    echo -e "${CYAN}#                   Gerenciar Contatos                       #${RESET}"
    echo -e "${CYAN}##############################################################${RESET}"
    echo -e "${CYAN}Menu de Gerenciamento de Contatos:${RESET}"
    echo -e "${GREEN}1) Adicionar Contato${RESET}"
    echo -e "${YELLOW}2) Listar Contatos${RESET}"
    echo -e "${MAGENTA}3) Visualizar Contato por Nome${RESET}"
    echo -e "${RED}4) Remover Contato${RESET}"
    echo -e "${BLUE}5) Voltar ao Menu Principal${RESET}"
    echo -en "${CYAN}Selecione uma opção: ${RESET}"
}

# Função para adicionar um contato
adicionar_contato() {
    echo -e "${GREEN}Adicionar Novo Contato${RESET}"
    read -p "Nome: " nome
    read -p "Telefone: " telefone
    read -p "Email: " email
    echo "$nome,$telefone,$email" >> contatos.txt
    echo -e "${GREEN}Contato adicionado com sucesso!${RESET}"
}

# Função para listar todos os contatos
listar_contatos() {
    echo -e "${YELLOW}Lista de Contatos:${RESET}"
    if [[ -f contatos.txt ]]; then
        cat -n contatos.txt | awk -F, '{print NR ") Nome: "$1", Telefone: "$2", Email: "$3}'
    else
        echo -e "${RED}Nenhum contato encontrado.${RESET}"
    fi
}

# Função para visualizar um contato pelo nome
visualizar_contato_nome() {
    read -p "Digite o nome do contato: " nome_contato
    if [[ -f contatos.txt ]]; then
        contato=$(grep -i "^$nome_contato," contatos.txt)
        if [[ -z $contato ]]; then
            echo -e "${RED}Contato não encontrado!${RESET}"
        else
            IFS=',' read -r nome telefone email <<< "$contato"
            echo -e "${YELLOW}Detalhes do Contato:${RESET}"
            echo -e "${YELLOW}Nome: $nome${RESET}"
            echo -e "${YELLOW}Telefone: $telefone${RESET}"
            echo -e "${YELLOW}Email: $email${RESET}"
        fi
    else
        echo -e "${RED}Nenhum contato encontrado.${RESET}"
    fi
}

# Função para remover um contato
remover_contato() {
    listar_contatos
    read -p "Selecione o número do contato que deseja remover: " num_contato
    if [[ -f contatos.txt ]]; then
        sed -i "${num_contato}d" contatos.txt
        echo -e "${GREEN}Contato removido com sucesso!${RESET}"
    else
        echo -e "${RED}Nenhum contato encontrado.${RESET}"
    fi
}

# Função para gerenciar os contatos
gerenciar_contatos() {
    while true; do
        exibir_menu_contatos
        read escolha_contatos
        case $escolha_contatos in
            1) adicionar_contato ;;
            2) listar_contatos ;;
            3) visualizar_contato_nome ;;
            4) remover_contato ;;
            5) break ;;
            *) echo -e "${RED}Opção inválida!${RESET}" ;;
        esac
        echo -e "Pressione Enter para continuar..."
        read
    done
}

# Função para exibir o menu da calculadora
exibir_menu_calculadora() {
    clear
    echo -e "${CYAN}##############################################################${RESET}"
    echo -e "${CYAN}#                        Calculadora                         #${RESET}"
    echo -e "${CYAN}##############################################################${RESET}"
    echo -e "${CYAN}Selecione a operação:${RESET}"
    echo -e "${GREEN}1) Adição${RESET}"
    echo -e "${YELLOW}2) Subtração${RESET}"
    echo -e "${MAGENTA}3) Multiplicação${RESET}"
    echo -e "${RED}4) Divisão${RESET}"
    echo -e "${BLUE}5) Voltar ao Menu Principal${RESET}"
    echo -en "${CYAN}Selecione uma operação: ${RESET}"
}

# Função para realizar a operação matemática
calcular() {
    read -p "Digite o primeiro operando: " op1
    read -p "Digite o segundo operando: " op2
    case $1 in
        1) resultado=$(echo "$op1 + $op2" | bc); echo -e "${GREEN}Resultado: $op1 + $op2 = $resultado${RESET}" ;;
        2) resultado=$(echo "$op1 - $op2" | bc); echo -e "${GREEN}Resultado: $op1 - $op2 = $resultado${RESET}" ;;
        3) resultado=$(echo "$op1 * $op2" | bc); echo -e "${GREEN}Resultado: $op1 * $op2 = $resultado${RESET}" ;;
        4)
            if [[ $op2 == 0 ]]; then
                echo -e "${RED}Erro: Divisão por zero não é permitida.${RESET}"
            else
                resultado=$(echo "scale=2; $op1 / $op2" | bc); echo -e "${GREEN}Resultado: $op1 / $op2 = $resultado${RESET}"
            fi
            ;;
        *) echo -e "${RED}Operação inválida!${RESET}" ;;
    esac
}

# Função para gerenciar a calculadora
gerenciar_calculadora() {
    while true; do
        exibir_menu_calculadora
        read escolha_calculadora
        case $escolha_calculadora in
            1) calcular 1 ;;
            2) calcular 2 ;;
            3) calcular 3 ;;
            4) calcular 4 ;;
            5) break ;;
            *) echo -e "${RED}Opção inválida!${RESET}" ;;
        esac
        echo -e "Pressione Enter para continuar..."
        read
    done
}

# Função para exibir as informações do Sistema
informacoes_do_sistema() {
    clear 
    echo -e "${CYAN}##############################################################${RESET}"
    echo -e "${CYAN}#                  Informações do Sistema                    #${RESET}"
    echo -e "${CYAN}##############################################################${RESET}"
    echo -e "${CYAN}Informações do Sistema:${RESET}"
    echo -e "${CYAN}=======================${RESET}"
    echo -e "${GREEN}Usuário Logado: $(hostname)${RESET}"
    echo -e "${GREEN}Kernel: $(uname -r)${RESET}"
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        echo -e "${GREEN}Distribuição: $NAME${RESET}"
        echo -e "${GREEN}Versão: $VERSION${RESET}"
    fi
    echo -e "${GREEN}Arquitetura do Sistema: $(arch)${RESET}"
    echo -e "${GREEN}Informações da CPU:${RESET}"
    echo -e "${GREEN}Modelo da CPU: $(cat /proc/cpuinfo | grep 'model name' | uniq | awk -F ':' '{print $2}')${RESET}"
    echo -e "${GREEN}Número de núcleos: $(cat /proc/cpuinfo | grep 'processor' | wc -l)${RESET}"
    echo -e "${GREEN}Total de Memória RAM: $(free -m | grep Mem | awk '{print $2}') MB${RESET}"
    echo -e "${GREEN}Uso de Disco:${RESET}"
    df -h | grep -E '/dev/sd|/dev/nv'
    echo -e "${GREEN}Endereço IP: $(hostname -I)${RESET}"
    echo -e "${GREEN}Data e Hora Atuais: $(date)${RESET}"
    echo -e "${GREEN}Usuários do Sistema:${RESET}"
    cut -d ':' -f 1 /etc/passwd
    echo -e "${CYAN}=======================${RESET}"
    echo -e "${CYAN}Por favor, selecione o sistema que você está usando para listar os pacotes:${RESET}"
    echo -e "${GREEN}1. Debian/Ubuntu${RESET}"
    echo -e "${YELLOW}2. Red Hat/CentOS${RESET}"
    echo -e "${MAGENTA}3. Não mostrar pacotes${RESET}"
    read -p "${CYAN}Digite o número correspondente ao seu sistema: ${RESET}" opcao
    if [ "$opcao" == "1" ]; then
        echo -e "${GREEN}Pacotes Instalados (Debian/Ubuntu):${RESET}"
        dpkg -l | grep '^ii' | awk '{print $2}'
    elif [ "$opcao" == "2" ]; then
        echo -e "${YELLOW}Pacotes Instalados (Red Hat/CentOS):${RESET}"
        rpm -qa
    elif [ "$opcao" == "3" ]; then
        echo -e "${RED}Saindo do Script....${RESET}"
    else
        echo -e "${RED}Opção inválida. Por favor, selecione 1, 2 ou 3.${RESET}"
    fi
}

# Função para finalizar o programa
finalizar() {
    echo -e "${RED}Finalizando o programa...${RESET}"
    exit 0
}

# Loop principal do script
while true; do
    mostrar_cabecalho
    exibir_menu_principal
    read -r opcao
    processar_escolha "$opcao"
    echo -e "\nPressione Enter para continuar..."
    read -r
done
