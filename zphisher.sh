#!/bin/bash

# ================== CORES ==================
GREEN="\e[1;92m"
CYAN="\e[1;96m"
PURPLE="\e[1;95m"
YELLOW="\e[1;93m"
RED="\e[1;91m"
GRAY="\e[1;90m"
WHITE="\e[1;97m"
ORANGE="\e[38;5;208m"
RESET="\e[0m"
BOLD="\e[1m"

# ================== CONFIG ==================
SITES_DIR=".sites"
PORT="8080"

trap 'printf "\n${YELLOW}Encerrando...${RESET}\n"; exit 0' INT

# ================== UTIL ==================
separator() {
  printf "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

timestamp() {
  date '+%H:%M:%S'
}

success() {
  printf "${GRAY}[%s]${RESET} ${GREEN}✔${RESET} %b\n" "$(timestamp)" "$1"
}

warn() {
  printf "${GRAY}[%s]${RESET} ${YELLOW}⚠${RESET} %b\n" "$(timestamp)" "$1"
}

error() {
  printf "${GRAY}[%s]${RESET} ${RED}✖${RESET} %b\n" "$(timestamp)" "$1"
}

# ================== INTRO ==================
intro() {
  clear
  sleep 0.3
}

# ================== BANNER ==================
banner() {
  separator
  printf "${GREEN}${BOLD}"
  cat << "EOF"
███╗   ███╗ █████╗ ██╗     ██████╗  ██████╗ ███████╗ ██████╗
████╗ ████║██╔══██╗██║     ██╔══██╗██╔═══██╗██╔════╝██╔═══██╗
██╔████╔██║███████║██║     ██║  ██║██║   ██║███████╗██║   ██║
██║╚██╔╝██║██╔══██║██║     ██║  ██║██║   ██║╚════██║██║   ██║
██║ ╚═╝ ██║██║  ██║███████╗██████╔╝╚██████╔╝███████║╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝
EOF
  printf "${RESET}"
  separator
  printf "${GRAY}Servidor Local para Sites HTML${RESET}\n"
  separator
}

# ================== SERVIDOR ==================
start_server() {

  site="$1"

  if [ ! -d "$SITES_DIR/$site" ]; then
    error "Pasta $site não encontrada!"
    sleep 2
    return
  fi

  echo
  read -p "Escolha a porta (padrão 8080): " custom_port

  if [ -n "$custom_port" ]; then
    PORT="$custom_port"
  else
    PORT="8080"
  fi

  cd "$SITES_DIR/$site" || {
    error "Erro ao entrar na pasta!"
    sleep 2
    return
  }

  success "Servidor iniciado em http://127.0.0.1:$PORT"
  sleep 1

  xdg-open "http://127.0.0.1:$PORT" > /dev/null 2>&1 &

  python3 -m http.server "$PORT"

  cd - > /dev/null 2>&1
}

# ================== MENU ==================
main_menu() {
  while true; do
    { clear; banner; echo; }

    cat <<- EOF
	${RED}[${WHITE}::${RED}]${ORANGE} selecionar ${RED}[${WHITE}::${RED}]${ORANGE}

	${RED}[${WHITE}01${RED}]${ORANGE} site1
	${RED}[${WHITE}02${RED}]${ORANGE} site2
	${RED}[${WHITE}03${RED}]${ORANGE} site3
	${RED}[${WHITE}04${RED}]${ORANGE} site4
	${RED}[${WHITE}05${RED}]${ORANGE} site5

	${RED}[${WHITE}99${RED}]${ORANGE} About
	${RED}[${WHITE}00${RED}]${ORANGE} Exit
	EOF

    echo
    read -p "Escolha uma opção: " option

    case $option in
      1|01) start_server "site1" ;;
      2|02) start_server "site2" ;;
      3|03) start_server "site3" ;;
      4|04) start_server "site4" ;;
      5|05) start_server "site5" ;;
      99)
        echo
        echo -e "${CYAN}Framework simples para servir sites locais via Python${RESET}"
        sleep 2
        ;;
      0|00) exit 0 ;;
      *)
        warn "Opção inválida!"
        sleep 1
        ;;
    esac
  done
}

# ================== START ==================
intro
main_menu