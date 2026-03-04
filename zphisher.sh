#!/bin/bash
# =====================================================
# MALDOSO FRAMEWORK - DEMO VISUAL
# Terminal Hacker Aesthetic Framework
# =====================================================

# ================== CORES ==================
GREEN="\033[1;92m"
CYAN="\033[1;96m"
PURPLE="\033[1;95m"
YELLOW="\033[1;93m"
RED="\033[1;91m"
GRAY="\033[1;90m"
WHITE="\033[1;97m"
RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"

# ================== ÍCONES ==================
ICON_OK="🟢 ✔"
ICON_INFO="ℹ️"
ICON_WAIT="⏳"
ICON_WARN="⚠️"
ICON_ERR="❌"
ICON_CAP="📸 🎯"
ICON_NET="🌐"

trap 'printf "\n${YELLOW}${ICON_WARN} Encerrando...${RESET}\n"; exit 0' INT

# ================== UTIL ==================
separator() {
  printf "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

timestamp() {
  date '+%H:%M:%S'
}

success() {
  printf "${GRAY}[%s]${RESET} ${GREEN}${ICON_OK}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

info() {
  printf "${GRAY}[%s]${RESET} ${CYAN}${ICON_INFO}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

warn() {
  printf "${GRAY}[%s]${RESET} ${YELLOW}${ICON_WARN}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

error() {
  printf "${GRAY}[%s]${RESET} ${RED}${ICON_ERR}${RESET} ${GRAY}%b${RESET}\n" "$(timestamp)" "$1"
}

# ================== GLITCH ==================
glitch_text() {
  final="$1"
  charset='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%'
  length=${#final}

  for _ in {1..6}; do
    out=""
    for ((i=0; i<length; i++)); do
      [[ "${final:$i:1}" == " " ]] && out+=" " || out+=${charset:RANDOM%${#charset}:1}
    done
    printf "\r${CYAN}%s${RESET}" "$out"
    sleep 0.05
  done
  printf "\r${GREEN}%s${RESET}\n" "$final"
}

# ================== SPINNER ==================
spinner() {
  local spin='|/-\'
  for i in {1..24}; do
    printf "\r${PURPLE}%s${RESET} ${GRAY}Inicializando módulos...${RESET}" "${spin:i%4:1}"
    sleep 0.07
  done
  printf "\r${GREEN}${ICON_OK}${RESET} ${GRAY}Módulos carregados${RESET}\n"
}

# ================== INTRO ==================
intro() {
  clear
  for _ in {1..3}; do
    printf "${GREEN}%s${RESET}\n" "$(head /dev/urandom | tr -dc 'A-Z0-9' | head -c $(tput cols))"
    sleep 0.04
  done
  clear
}

# ================== BANNER ==================
banner() {
  separator
  printf "${GREEN}${BOLD}"
  cat << EOF
███╗   ███╗ █████╗ ██╗     ██████╗  ██████╗ ███████╗ ██████╗
████╗ ████║██╔══██╗██║     ██╔══██╗██╔═══██╗██╔════╝██╔═══██╗
██╔████╔██║███████║██║     ██║  ██║██║   ██║███████╗██║   ██║
██║╚██╔╝██║██╔══██║██║     ██║  ██║██║   ██║╚════██║██║   ██║
██║ ╚═╝ ██║██║  ██║███████╗██████╔╝╚██████╔╝███████║╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝
EOF
  printf "${RESET}"
  separator
  printf "${GREEN}>> Framework de Engenharia Social & Captura <<${RESET}\n"
  printf "${GRAY}:: Autor  : Duzinn${RESET}\n"
  printf "${GRAY}:: Versão : 1.0${RESET}\n"
  printf "${GRAY}:: Modo   : DEMO${RESET}\n"
  separator
}

# ================== MENU DEMO ==================
menu_demo() {
  echo
  printf "${RED}[${WHITE}01${RED}]${CYAN} Iniciar Demo${RESET}\n"
  printf "${RED}[${WHITE}00${RED}]${CYAN} Sair${RESET}\n"
  echo
  read -p "Escolha: " op

  case $op in
    1|01)
      success "Demo iniciada"
      sleep 1
      ;;
    0|00)
      warn "Encerrando framework"
      sleep 0.8
      clear
      exit 0
      ;;
    *)
      error "Opção inválida"
      sleep 1
      ;;
  esac
}

# ================== EXECUÇÃO ==================
intro
glitch_text "MALDOSO FRAMEWORK"
glitch_text "Inicializando ambiente"
spinner
banner
menu_demo