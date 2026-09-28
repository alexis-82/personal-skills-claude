#!/usr/bin/env bash
# Installazione skill Feature-Driven Workflow per Claude Code (Linux/macOS)
# Uso: ./install.sh

set -euo pipefail

SKILLS=(
    spec
    clarify
    plan-tasks
    analyze
    implement
    test
    review
    refactor
    commit
    guardrail-scope
)

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.claude/skills"

# Colori (disabilita se stdout non è un terminale)
if [ -t 1 ]; then
    C_CYAN='\033[0;36m'
    C_GREEN='\033[0;32m'
    C_YELLOW='\033[0;33m'
    C_RESET='\033[0m'
else
    C_CYAN=''; C_GREEN=''; C_YELLOW=''; C_RESET=''
fi

printf "${C_CYAN}Installazione skill in: %s${C_RESET}\n\n" "$TARGET_DIR"

mkdir -p "$TARGET_DIR"

# Copia (o sovrascrivi) le skill correnti
installed=0
for skill in "${SKILLS[@]}"; do
    src="$SOURCE_DIR/$skill"
    dst="$TARGET_DIR/$skill"

    if [ ! -d "$src" ]; then
        printf "  ${C_YELLOW}!! sorgente mancante:${C_RESET} %s (skip)\n" "$src"
        continue
    fi

    rm -rf "$dst"
    cp -r "$src" "$dst"
    printf "  ${C_GREEN}OK${C_RESET}  %s\n" "$skill"
    installed=$((installed + 1))
done

echo
printf "${C_CYAN}Installate %d/%d skill.${C_RESET}\n" "$installed" "${#SKILLS[@]}"
echo "Riavvia Claude Code per caricarle."
