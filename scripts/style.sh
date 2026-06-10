#!/bin/bash

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
RESET='\033[0m'

BANNER="============================================"
SEP="  ------------------------------------------"

label()  { printf "  %-22s ${CYAN}%s${RESET}\n" "$1" "$2"; }
info()   { printf "  %s\n" "$1"; }
indent() { printf "    - %s\n" "$1"; }
