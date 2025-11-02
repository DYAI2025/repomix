# Repomix Scripts

Dieses Verzeichnis enthält hilfreiche Scripts für erweiterte Repomix-Workflows.

## 🚀 Multi-Repository Fusion Script

**Datei:** `multi-repo-fusion.sh`

Ein Bash-Script zum einfachen Kombinieren mehrerer Repositories für KI-gestützte Feature-Emergence und Cross-Repository-Analyse.

### Verwendung

#### Basis-Verwendung
```bash
./scripts/multi-repo-fusion.sh user/repo1 user/repo2
```

#### Mit Optionen
```bash
./scripts/multi-repo-fusion.sh \
  --format markdown \
  --no-local \
  facebook/react \
  vercel/next.js \
  remix-run/remix
```

### Optionen

| Option | Beschreibung | Standard |
|--------|--------------|----------|
| `--no-compress` | Keine Code-Kompression verwenden | Kompression aktiv |
| `--no-local` | Lokales Projekt nicht einbeziehen | Lokales Projekt inkludiert |
| `--format FORMAT` | Ausgabeformat (xml, markdown, plain) | xml |
| `--output-dir DIR` | Output-Verzeichnis | ./fusion-output |
| `--help, -h` | Hilfe anzeigen | - |

### Beispiele

#### Beispiel 1: Zwei Repositories fusionieren
```bash
./scripts/multi-repo-fusion.sh awesome/auth-lib cool/ui-components
```
Erstellt:
- `fusion-output/01-repo-awesome-auth-lib.xml`
- `fusion-output/02-repo-cool-ui-components.xml`
- `fusion-output/03-my-project.xml`

#### Beispiel 2: Drei Frameworks vergleichen
```bash
./scripts/multi-repo-fusion.sh \
  --format markdown \
  --no-local \
  vercel/next.js \
  remix-run/remix \
  solidjs/solid-start
```
Erstellt:
- `fusion-output/01-repo-vercel-next.js.md`
- `fusion-output/02-repo-remix-run-remix.md`
- `fusion-output/03-repo-solidjs-solid-start.md`

#### Beispiel 3: Custom Output-Verzeichnis
```bash
./scripts/multi-repo-fusion.sh \
  --output-dir ./my-analysis \
  facebook/react \
  vuejs/core
```

### Features

✨ **Automatische Nummerierung** - Repositories werden automatisch durchnummeriert
📊 **Token-Schätzung** - Ungefähre Berechnung der Token-Anzahl
🎯 **KI-Empfehlungen** - Automatische Empfehlung des besten KI-Models
🎨 **Farbiger Output** - Übersichtliche Terminal-Ausgabe
📋 **Nächste Schritte** - Fertige Prompts für die KI-Verwendung

### Workflow

1. **Script ausführen** mit gewünschten Repositories
2. **Warten** bis alle Repos verpackt sind
3. **Dateien hochladen** in Claude/ChatGPT/Gemini
4. **Prompt verwenden** (wird vom Script vorgeschlagen)

### Output-Beispiel

```
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║     🚀 Repomix Multi-Repository Fusion Script 🚀          ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝

📋 Konfiguration:
   Repositories: 2
   Kompression: true
   Lokales Projekt: true
   Format: xml
   Output: ./fusion-output

📊 Analysiere Repository-Größen...

📦 Repository 1/2: awesome/auth-lib
   ✅ Erfolgreich: 01-repo-awesome-auth-lib.xml (156K)
   📊 Geschätzte Tokens: ~15,234

📦 Repository 2/2: cool/ui-components
   ✅ Erfolgreich: 02-repo-cool-ui-components.xml (423K)
   📊 Geschätzte Tokens: ~48,921

📦 Lokales Projekt
   ✅ Erfolgreich: 03-my-project.xml (289K)
   📊 Geschätzte Tokens: ~32,156

╔════════════════════════════════════════════════════════════╗
║                    ✅ FUSION ABGESCHLOSSEN                  ║
╚════════════════════════════════════════════════════════════╝

📊 Statistiken:
   ✅ Erfolgreich verpackt: 3 Repositories
   📈 Geschätzte Gesamt-Tokens: ~96,311

🤖 KI-Model Empfehlungen:
   ✅ Claude 3.5 Sonnet (200k limit) - PERFEKT
   ✅ GPT-4 Turbo (128k limit) - GUT
   ✅ Gemini 1.5 Pro (2M limit) - OVERKILL
```

### Voraussetzungen

- Bash Shell
- `repomix` installiert (global oder via npx)

### Installation von Repomix

```bash
# Global installieren
npm install -g repomix

# Oder ohne Installation verwenden
npx repomix
```

## 📚 Weitere Ressourcen

- [Hauptdokumentation](../README.md)
- [Deutsche Anleitung](../REPOMIX_ANLEITUNG_DE.md)
- [Multi-Repo Praktische Analyse](../MULTI_REPO_PRAKTISCH.md)

## 💡 Tipps

1. **Token-Limits beachten**: Für große Repos `--compress` verwenden (ist Standard)
2. **Inkrementell arbeiten**: Erst mit `--no-files` Struktur analysieren
3. **Gezielte Auswahl**: Mit `--include` nur relevante Bereiche verpacken
4. **Format wählen**: XML für Claude optimal, Markdown für bessere Lesbarkeit

## 🤝 Beitragen

Weitere hilfreiche Scripts? Pull Request willkommen!
