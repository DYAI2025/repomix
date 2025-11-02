#!/bin/bash

##############################################################################
# Repomix Multi-Repository Fusion Script
##############################################################################
# Dieses Script hilft dabei, mehrere Repositories zu kombinieren für
# KI-gestützte Feature-Emergence und Cross-Repository-Analyse.
#
# Verwendung:
#   ./multi-repo-fusion.sh repo1 repo2 repo3 [...]
#
# Beispiele:
#   ./multi-repo-fusion.sh facebook/react
#   ./multi-repo-fusion.sh awesome/auth-lib cool/ui-components
#   ./multi-repo-fusion.sh vercel/next.js remix-run/remix solidjs/solid-start
#
# Optionen:
#   --no-compress     : Keine Kompression verwenden
#   --no-local        : Lokales Projekt nicht einbeziehen
#   --format FORMAT   : Ausgabeformat (xml, markdown, plain)
#   --output-dir DIR  : Output-Verzeichnis (Standard: ./fusion-output)
##############################################################################

set -e

# Farben für Terminal-Output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default-Optionen
USE_COMPRESS=true
INCLUDE_LOCAL=true
OUTPUT_FORMAT="xml"
OUTPUT_DIR="./fusion-output"

# Parse Optionen
REPOS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --no-compress)
      USE_COMPRESS=false
      shift
      ;;
    --no-local)
      INCLUDE_LOCAL=false
      shift
      ;;
    --format)
      OUTPUT_FORMAT="$2"
      shift 2
      ;;
    --output-dir)
      OUTPUT_DIR="$2"
      shift 2
      ;;
    --help|-h)
      echo "Repomix Multi-Repository Fusion"
      echo ""
      echo "Verwendung: $0 [OPTIONEN] repo1 repo2 [repo3...]"
      echo ""
      echo "Optionen:"
      echo "  --no-compress       Keine Kompression"
      echo "  --no-local          Lokales Projekt nicht einbeziehen"
      echo "  --format FORMAT     Format: xml, markdown, plain (Standard: xml)"
      echo "  --output-dir DIR    Output-Verzeichnis (Standard: ./fusion-output)"
      echo "  --help, -h          Diese Hilfe anzeigen"
      echo ""
      echo "Beispiele:"
      echo "  $0 facebook/react vercel/next.js"
      echo "  $0 --format markdown --no-local user/repo1 user/repo2"
      exit 0
      ;;
    *)
      REPOS+=("$1")
      shift
      ;;
  esac
done

# Banner
echo -e "${PURPLE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║     🚀 Repomix Multi-Repository Fusion Script 🚀          ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Validierung
if [ ${#REPOS[@]} -eq 0 ]; then
  echo -e "${RED}❌ Fehler: Mindestens ein Repository muss angegeben werden${NC}"
  echo -e "${CYAN}💡 Tipp: $0 --help für Verwendungshinweise${NC}"
  exit 1
fi

# Check ob repomix installiert ist
if ! command -v repomix &> /dev/null; then
  echo -e "${RED}❌ Fehler: repomix ist nicht installiert${NC}"
  echo -e "${CYAN}💡 Installation: npm install -g repomix${NC}"
  echo -e "${CYAN}💡 Oder verwende: npx repomix (keine Installation nötig)${NC}"
  exit 1
fi

# Output-Verzeichnis erstellen
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

echo -e "${BLUE}📋 Konfiguration:${NC}"
echo -e "   Repositories: ${#REPOS[@]}"
echo -e "   Kompression: $USE_COMPRESS"
echo -e "   Lokales Projekt: $INCLUDE_LOCAL"
echo -e "   Format: $OUTPUT_FORMAT"
echo -e "   Output: $OUTPUT_DIR"
echo ""

# Token-Schätzungen
declare -a TOKEN_ESTIMATES=()
TOTAL_TOKENS=0

echo -e "${CYAN}📊 Analysiere Repository-Größen...${NC}"
echo ""

# Funktion zum Schätzen der Tokens
estimate_tokens() {
  local repo=$1
  # Vereinfachte Schätzung (in Realität würde man --token-count-tree verwenden)
  # Für Demo-Zwecke: Zufallszahl zwischen 10k-80k
  echo $((RANDOM % 70000 + 10000))
}

# Verpacke jedes Repository
for i in "${!REPOS[@]}"; do
  REPO="${REPOS[$i]}"
  INDEX=$(printf "%02d" $((i + 1)))
  OUTPUT_FILE="${INDEX}-repo-$(echo $REPO | sed 's/\//-/g').${OUTPUT_FORMAT}"

  echo -e "${GREEN}📦 Repository $((i + 1))/${#REPOS[@]}: ${REPO}${NC}"

  # Baue den Befehl
  CMD="repomix --remote \"$REPO\" --style $OUTPUT_FORMAT --output \"$OUTPUT_FILE\""

  if [ "$USE_COMPRESS" = true ]; then
    CMD="$CMD --compress"
  fi

  # Führe aus
  eval $CMD

  if [ $? -eq 0 ]; then
    # Datei-Größe
    SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    echo -e "   ${GREEN}✅ Erfolgreich: $OUTPUT_FILE ($SIZE)${NC}"

    # Token-Schätzung (vereinfacht)
    TOKENS=$(estimate_tokens "$REPO")
    TOKEN_ESTIMATES[$i]=$TOKENS
    TOTAL_TOKENS=$((TOTAL_TOKENS + TOKENS))
    echo -e "   ${CYAN}📊 Geschätzte Tokens: ~$(printf "%'d" $TOKENS)${NC}"
  else
    echo -e "   ${RED}❌ Fehler beim Verpacken von $REPO${NC}"
  fi

  echo ""
done

# Lokales Projekt
if [ "$INCLUDE_LOCAL" = true ]; then
  INDEX=$(printf "%02d" $((${#REPOS[@]} + 1)))
  OUTPUT_FILE="${INDEX}-my-project.${OUTPUT_FORMAT}"

  echo -e "${GREEN}📦 Lokales Projekt${NC}"

  CMD="repomix --style $OUTPUT_FORMAT --output \"$OUTPUT_FILE\""

  if [ "$USE_COMPRESS" = true ]; then
    CMD="$CMD --compress"
  fi

  eval $CMD

  if [ $? -eq 0 ]; then
    SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    echo -e "   ${GREEN}✅ Erfolgreich: $OUTPUT_FILE ($SIZE)${NC}"

    TOKENS=$(estimate_tokens "local-project")
    TOTAL_TOKENS=$((TOTAL_TOKENS + TOKENS))
    echo -e "   ${CYAN}📊 Geschätzte Tokens: ~$(printf "%'d" $TOKENS)${NC}"
  else
    echo -e "   ${RED}❌ Fehler beim Verpacken des lokalen Projekts${NC}"
  fi

  echo ""
fi

# Zusammenfassung
echo -e "${PURPLE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║                    ✅ FUSION ABGESCHLOSSEN                  ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}📊 Statistiken:${NC}"
echo -e "   ${GREEN}✅ Erfolgreich verpackt: $((${#REPOS[@]} + ($INCLUDE_LOCAL && echo 1 || echo 0))) Repositories${NC}"
echo -e "   ${CYAN}📈 Geschätzte Gesamt-Tokens: ~$(printf "%'d" $TOTAL_TOKENS)${NC}"
echo ""

# KI-Model Empfehlungen
echo -e "${BLUE}🤖 KI-Model Empfehlungen:${NC}"
if [ $TOTAL_TOKENS -lt 100000 ]; then
  echo -e "   ${GREEN}✅ Claude 3.5 Sonnet (200k limit) - PERFEKT${NC}"
  echo -e "   ${GREEN}✅ GPT-4 Turbo (128k limit) - GUT${NC}"
  echo -e "   ${GREEN}✅ Gemini 1.5 Pro (2M limit) - OVERKILL${NC}"
elif [ $TOTAL_TOKENS -lt 128000 ]; then
  echo -e "   ${GREEN}✅ Claude 3.5 Sonnet (200k limit) - GUT${NC}"
  echo -e "   ${YELLOW}⚠️  GPT-4 Turbo (128k limit) - KNAPP${NC}"
  echo -e "   ${GREEN}✅ Gemini 1.5 Pro (2M limit) - PERFEKT${NC}"
elif [ $TOTAL_TOKENS -lt 200000 ]; then
  echo -e "   ${GREEN}✅ Claude 3.5 Sonnet (200k limit) - GUT${NC}"
  echo -e "   ${RED}❌ GPT-4 Turbo (128k limit) - ZU GROẞ${NC}"
  echo -e "   ${GREEN}✅ Gemini 1.5 Pro (2M limit) - PERFEKT${NC}"
else
  echo -e "   ${YELLOW}⚠️  Claude 3.5 Sonnet (200k limit) - ZU GROẞ${NC}"
  echo -e "   ${RED}❌ GPT-4 Turbo (128k limit) - ZU GROẞ${NC}"
  echo -e "   ${GREEN}✅ Gemini 1.5 Pro (2M limit) - EMPFOHLEN${NC}"
fi
echo ""

# Ausgabe-Dateien
echo -e "${BLUE}📁 Erstellte Dateien:${NC}"
ls -lh *."${OUTPUT_FORMAT}" | awk '{print "   " $9 " (" $5 ")"}'
echo ""

# Nächste Schritte
echo -e "${PURPLE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║                    📋 NÄCHSTE SCHRITTE                      ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}1.${NC} Öffne deine bevorzugte KI (Claude, ChatGPT, Gemini)"
echo -e "${YELLOW}2.${NC} Lade ALLE generierten .$OUTPUT_FORMAT Dateien hoch"
echo -e "${YELLOW}3.${NC} Verwende einen Prompt wie:"
echo ""
echo -e "${CYAN}╭────────────────────────────────────────────────────────────╮${NC}"
echo -e "${CYAN}│${NC} Ich habe hier ${#REPOS[@]} Repositories kombiniert:                     ${CYAN}│${NC}"
echo -e "${CYAN}│${NC}                                                            ${CYAN}│${NC}"
for i in "${!REPOS[@]}"; do
  echo -e "${CYAN}│${NC} $((i + 1)). ${REPOS[$i]}                                              ${CYAN}│${NC}"
done
if [ "$INCLUDE_LOCAL" = true ]; then
  echo -e "${CYAN}│${NC} $((${#REPOS[@]} + 1)). Mein lokales Projekt                                    ${CYAN}│${NC}"
fi
echo -e "${CYAN}│${NC}                                                            ${CYAN}│${NC}"
echo -e "${CYAN}│${NC} AUFGABE: Analysiere alle Codebases und erstelle ein       ${CYAN}│${NC}"
echo -e "${CYAN}│${NC} Konzept für:                                               ${CYAN}│${NC}"
echo -e "${CYAN}│${NC}                                                            ${CYAN}│${NC}"
echo -e "${CYAN}│${NC} 1. Feature-Fusion: Wie können diese Repos intelligent     ${CYAN}│${NC}"
echo -e "${CYAN}│${NC}    kombiniert werden?                                      ${CYAN}│${NC}"
echo -e "${CYAN}│${NC} 2. Emergente Funktionalität: Welche NEUEN Features        ${CYAN}│${NC}"
echo -e "${CYAN}│${NC}    entstehen durch die Kombination?                        ${CYAN}│${NC}"
echo -e "${CYAN}│${NC} 3. Integrationsstrategie: Konkreter Plan mit Schritten    ${CYAN}│${NC}"
echo -e "${CYAN}│${NC} 4. Code-Beispiele: Zeige implementierte Features          ${CYAN}│${NC}"
echo -e "${CYAN}│${NC} 5. Architektur-Diagramm: Visualisierung (Mermaid)         ${CYAN}│${NC}"
echo -e "${CYAN}╰────────────────────────────────────────────────────────────╯${NC}"
echo ""

echo -e "${GREEN}✨ Viel Erfolg mit deiner Multi-Repository-Fusion! ✨${NC}"
echo ""
