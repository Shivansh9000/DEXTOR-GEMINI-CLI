#!/usr/bin/env bash
# Common utilities for the Agentic Dev Environment

# Text colors
RED="$(tput setaf 1 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '')"
BLUE="$(tput setaf 4 2>/dev/null || echo '')"
BOLD="$(tput bold 2>/dev/null || echo '')"
RESET="$(tput sgr0 2>/dev/null || echo '')"

# Logging functions
info() { printf "${BLUE}${BOLD}[INFO]${RESET} %s\n" "$*"; }
success() { printf "${GREEN}${BOLD}[OK]${RESET} %s\n" "$*"; }
warn() { printf "${YELLOW}${BOLD}[WARN]${RESET} %s\n" "$*"; }
error() { printf "${RED}${BOLD}[ERROR]${RESET} %s\n" "$*"; exit 1; }

# Utility functions
has() { command -v "$1" >/dev/null 2>&1; }

run() {
  if [[ "${DRY_RUN:-0}" -eq 1 ]]; then
    printf "${YELLOW}${BOLD}[DRY-RUN]${RESET} %q " "$@"; printf '\n'
  else
    "$@"
  fi
}

run_shell() {
  if [[ "${DRY_RUN:-0}" -eq 1 ]]; then
    printf "${YELLOW}${BOLD}[DRY-RUN-SHELL]${RESET} %s\n" "$*"
  else
    bash -lc "$*"
  fi
}

pause_if_live() {
  if [[ "${DRY_RUN:-0}" -eq 0 ]]; then
    read -r -p "${BOLD}>>> $1${RESET}" _
  fi
}

open_url() {
  local url="$1"
  if [[ "${DRY_RUN:-0}" -eq 1 ]]; then
    printf "${YELLOW}${BOLD}[DRY-RUN]${RESET} Would open URL: %s\n" "$url"
    return 0
  fi
  if has xdg-open; then
    xdg-open "$url" >/dev/null 2>&1 || true
  elif has open; then
    open "$url" || true
  else
    warn "No URL opener found; please open manually: $url"
  fi
}
