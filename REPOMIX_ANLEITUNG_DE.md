# Repomix - Umfassende Anleitung und Anwendungsfälle

## 📖 Was ist Repomix?

**Repomix** ist ein leistungsstarkes Tool, das Ihre gesamte Code-Repository in eine einzige, KI-freundliche Datei verpackt. Es wurde speziell entwickelt, um die Arbeit mit Large Language Models (LLMs) wie ChatGPT, Claude, DeepSeek, Gemini und anderen zu optimieren.

### Kernfunktion
Repomix sammelt alle relevanten Dateien Ihres Projekts und kombiniert sie in einer strukturierten, gut formatierten Ausgabedatei (XML, Markdown oder Plain Text), die perfekt für KI-Analyse geeignet ist.

---

## 🚀 Installation und Verwendung

### Option 1: Einmalige Verwendung (empfohlen)
```bash
npx repomix@latest
```
Diese Methode verwendet immer die neueste Version ohne Installation.

### Option 2: Globale Installation
```bash
# Mit npm
npm install -g repomix

# Mit yarn
yarn global add repomix

# Mit bun
bun add -g repomix

# Mit Homebrew (macOS/Linux)
brew install repomix

# Anschließend ausführen
repomix
```

### Option 3: Docker
```bash
docker run -v .:/app -it --rm ghcr.io/yamadashy/repomix
```

### Option 4: Browser-Extension
- [Chrome Extension](https://chromewebstore.google.com/detail/repomix/fimfamikepjgchehkohedilpdigcpkoa)
- [Firefox Add-on](https://addons.mozilla.org/firefox/addon/repomix/)

---

## 💡 Grundlegende Verwendung

### Gesamtes Projekt verpacken
```bash
repomix
```
Erstellt die Datei `repomix-output.xml` im aktuellen Verzeichnis.

### Spezifisches Verzeichnis verpacken
```bash
repomix src/
```

### Bestimmte Dateien einschließen
```bash
repomix --include "src/**/*.ts,**/*.md"
```

### Dateien ausschließen
```bash
repomix --ignore "**/*.log,tmp/"
```

### Remote Repository verarbeiten
```bash
# Vollständige URL
repomix --remote https://github.com/yamadashy/repomix

# GitHub Kurzform
repomix --remote yamadashy/repomix

# Spezifischer Branch
repomix --remote yamadashy/repomix --remote-branch main

# Spezifischer Commit
repomix --remote https://github.com/yamadashy/repomix/commit/836abcd
```

### Code-Kompression aktivieren
```bash
repomix --compress
```
Reduziert Token-Anzahl um ~70% durch intelligente Extraktion von Funktions- und Klassen-Signaturen.

### Ausgabe in verschiedenen Formaten
```bash
# Markdown-Format
repomix --style markdown

# Plain-Text-Format
repomix --style plain

# XML-Format (Standard)
repomix --style xml
```

### Ausgabe in Zwischenablage kopieren
```bash
repomix --copy
```

### Token-Baum anzeigen
```bash
# Alle Dateien
repomix --token-count-tree

# Nur Dateien mit mehr als 1000 Tokens
repomix --token-count-tree 1000
```

### Ausgabe direkt an stdout
```bash
# In Datei umleiten
repomix --stdout > output.txt

# Direkt an LLM-Tool weiterleiten
repomix --stdout | llm "Erkläre bitte, was dieser Code macht."
```

---

## ✨ Hauptvorteile von Repomix

### 1. **KI-Optimiert**
- Strukturierte Ausgabe im XML/Markdown/Plain-Text Format
- Speziell für LLMs optimierte Formatierung mit klaren Tags
- AI-orientierte Erklärungen am Anfang der Datei

### 2. **Token-Zählung**
- Genaue Token-Zählung pro Datei und für das gesamte Repository
- Token-Count-Tree zur Visualisierung der Token-Verteilung
- Hilft bei der Optimierung für LLM-Kontext-Limits
- Unterstützt verschiedene Encodings (o200k_base für GPT-4o, cl100k_base für GPT-4/3.5)

### 3. **Intelligent und Einfach**
- Ein Befehl genügt: `repomix`
- Automatische Erkennung von Projektstruktur
- Intelligente Standard-Ausschlüsse (node_modules, .git, etc.)

### 4. **Git-Integration**
- Respektiert automatisch `.gitignore` und `.git/info/exclude`
- Sortierung nach Git-Änderungshäufigkeit
- Optional: Git-Diffs in Ausgabe einbeziehen

### 5. **Sicherheitsfokus**
- Integriert [Secretlint](https://github.com/secretlint/secretlint) für Sicherheitschecks
- Erkennt potenziell sensible Informationen
- Warnt vor API-Keys, Passwörtern und Secrets

### 6. **Code-Kompression**
- Verwendet [Tree-sitter](https://github.com/tree-sitter/tree-sitter) für intelligente Code-Extraktion
- Behält Funktions- und Klassen-Signaturen bei
- Reduziert Token-Count um bis zu 70%
- Perfekt für große Codebases

### 7. **Hochgradig Konfigurierbar**
- JSON5-Konfigurationsdatei (`repomix.config.json`)
- Globale und projekt-spezifische Konfigurationen
- Benutzerdefinierte Anweisungen für KI
- Flexible Include/Ignore-Patterns

### 8. **Vielseitige Integration**
- CLI-Tool
- Node.js Library
- GitHub Actions
- MCP Server (Model Context Protocol)
- Browser Extension
- VSCode Extension (Community-maintained)

---

## 🎯 Reale Anwendungsfälle für Repomix

### Anwendungsfall 1: **Code-Review und Refactoring**
**Szenario:** Sie haben ein größeres Projekt geerbt und möchten eine umfassende Code-Review durchführen.

**Workflow:**
```bash
# Repository verpacken
repomix --compress

# Datei an Claude/ChatGPT senden mit folgendem Prompt:
```
```
Diese Datei enthält meine gesamte Codebasis. Bitte führe eine umfassende Code-Review durch und schlage Verbesserungen vor, mit Fokus auf:
- Wartbarkeit und Skalierbarkeit
- Best Practices
- Potenzielle Bugs
- Sicherheitsprobleme
- Performance-Optimierungen
```

**Vorteil:** Die KI hat vollständigen Kontext über alle Dateien und deren Zusammenhänge.

---

### Anwendungsfall 2: **Dokumentations-Generierung**
**Szenario:** Sie benötigen eine ausführliche README oder Entwickler-Dokumentation.

**Workflow:**
```bash
# Nur relevante Dateien verpacken
repomix --include "src/**/*.ts,src/**/*.js"

# Prompt für KI:
```
```
Basierend auf dieser Codebasis, generiere bitte:
1. Eine detaillierte README.md mit:
   - Projektübersicht
   - Hauptfeatures
   - Installationsanleitung
   - Verwendungsbeispiele
   - API-Dokumentation
2. Eine ARCHITECTURE.md die die Systemarchitektur erklärt
3. Eine CONTRIBUTING.md für neue Entwickler
```

---

### Anwendungsfall 3: **Test-Generierung**
**Szenario:** Sie möchten die Test-Abdeckung verbessern.

**Workflow:**
```bash
# Nur Source-Code ohne Tests verpacken
repomix --include "src/**/*.ts" --ignore "**/*.test.ts,**/*.spec.ts"

# Prompt:
```
```
Analysiere den Code und generiere umfassende Unit-Tests für die Hauptfunktionen und Klassen. Berücksichtige:
- Edge Cases
- Fehlerszenarien
- Integrationstests
- Verwende Vitest als Test-Framework
```

---

### Anwendungsfall 4: **Legacy-Code-Modernisierung**
**Szenario:** Migration von JavaScript zu TypeScript.

**Workflow:**
```bash
# Alle JavaScript-Dateien verpacken
repomix --include "**/*.js" --ignore "node_modules/**,dist/**"

# Prompt:
```
```
Konvertiere diese JavaScript-Codebasis zu TypeScript:
1. Füge korrekte TypeScript-Typen hinzu
2. Nutze moderne ES6+ Features
3. Implementiere Interfaces für Datenstrukturen
4. Behalte die vorhandene Funktionalität bei
5. Stelle sicher, dass der Code type-safe ist
```

---

### Anwendungsfall 5: **Bug-Analyse und Debugging**
**Szenario:** Ein komplexer Bug, der mehrere Dateien betrifft.

**Workflow:**
```bash
# Repository mit Git-Diffs verpacken
repomix --include-diffs

# Prompt:
```
```
Ich habe einen Bug: [Beschreibung des Bugs]

Analysiere die Codebasis und die aktuellen Änderungen und:
1. Identifiziere die wahrscheinliche Fehlerquelle
2. Erkläre den Fehler
3. Schlage eine Lösung vor
4. Zeige potenzielle Seiteneffekte der Lösung auf
```

---

### Anwendungsfall 6: **API-Design-Review**
**Szenario:** Überprüfung der API-Architektur vor einem Release.

**Workflow:**
```bash
# API-relevante Dateien verpacken
repomix --include "src/api/**/*,src/types/**/*,src/controllers/**/*"

# Prompt:
```
```
Überprüfe die API-Architektur auf:
1. REST-Best-Practices
2. Konsistenz der Endpoints
3. Fehlerbehandlung
4. Sicherheitsaspekte (Authentication, Authorization)
5. Datenvalidierung
6. Performance-Überlegungen
Schlage Verbesserungen vor.
```

---

### Anwendungsfall 7: **Onboarding neuer Entwickler**
**Szenario:** Ein neuer Entwickler soll schnell ins Projekt einsteigen.

**Workflow:**
```bash
# Projekt-Übersicht erstellen
repomix --no-files --directory-structure

# Dann vollständige Dokumentation
repomix --compress

# Prompt:
```
```
Erstelle ein umfassendes Onboarding-Dokument für neue Entwickler:
1. Projektübersicht und Ziele
2. Architektur-Diagramm (in Mermaid-Syntax)
3. Wichtigste Komponenten und deren Zweck
4. Datenfluss-Erklärung
5. Entwicklungs-Workflow
6. Häufige Entwicklungsaufgaben mit Beispielen
7. Wichtige Code-Patterns im Projekt
```

---

### Anwendungsfall 8: **Sicherheits-Audit**
**Szenario:** Sicherheitsüberprüfung vor einem wichtigen Release.

**Workflow:**
```bash
# Mit aktiviertem Security-Check
repomix --compress

# Prompt:
```
```
Führe ein umfassendes Sicherheits-Audit durch:
1. SQL-Injection-Risiken
2. XSS-Schwachstellen
3. CSRF-Schutz
4. Authentifizierungs-/Autorisierungsprobleme
5. Datenlecks
6. Unsichere Abhängigkeiten
7. Hardcodierte Credentials oder Secrets
8. Input-Validierung
Erstelle einen detaillierten Sicherheitsbericht mit Prioritäten.
```

---

### Anwendungsfall 9: **Performance-Optimierung**
**Szenario:** Anwendung läuft langsam, Optimierung erforderlich.

**Workflow:**
```bash
# Code mit Token-Tree analysieren
repomix --token-count-tree --compress

# Prompt:
```
```
Analysiere die Codebasis auf Performance-Probleme:
1. Identifiziere Performance-Bottlenecks
2. Überprüfe Datenbankabfragen
3. Suche nach ineffizienten Algorithmen
4. Prüfe auf Memory-Leaks
5. Bewerte Caching-Strategien
6. Analysiere Bundle-Größe und Code-Splitting
Schlage konkrete Optimierungen mit geschätztem Impact vor.
```

---

### Anwendungsfall 10: **Compliance und Code-Standards**
**Szenario:** Sicherstellen, dass der Code Unternehmens-Standards entspricht.

**Workflow:**
```bash
# Mit benutzerdefinierten Anweisungen
repomix --instruction-file-path company-standards.md

# Datei company-standards.md:
```
```markdown
# Unternehmens-Code-Standards
- Alle Funktionen müssen JSDoc-Kommentare haben
- Maximale Funktionslänge: 50 Zeilen
- Verwende TypeScript strict mode
- Keine console.log in Production-Code
- Alle API-Aufrufe müssen Fehlerbehandlung haben
- Folge dem Airbnb Style Guide
```

**Prompt für KI:**
```
Überprüfe die Codebasis auf Einhaltung der Unternehmens-Standards.
Erstelle einen Bericht mit:
1. Violations und deren Schweregrad
2. Datei-spezifische Probleme
3. Refactoring-Vorschläge
4. Geschätzter Aufwand für Fixes
```

---

## 🛠️ Erweiterte Konfiguration

### Konfigurationsdatei erstellen
```bash
repomix --init
```

### Beispiel-Konfiguration (`repomix.config.json`)
```json5
{
  "output": {
    "filePath": "repomix-output.xml",
    "style": "xml",
    "compress": false,
    "headerText": "Projektspezifische Hinweise",
    "instructionFilePath": "repomix-instruction.md",
    "fileSummary": true,
    "directoryStructure": true,
    "removeComments": false,
    "showLineNumbers": false,
    "topFilesLength": 5,
    "tokenCountTree": false,
    "copyToClipboard": false,
    "git": {
      "sortByChanges": true,
      "includeDiffs": false
    }
  },
  "include": ["src/**/*", "docs/**/*"],
  "ignore": {
    "useGitignore": true,
    "useDefaultPatterns": true,
    "customPatterns": [
      "**/*.log",
      "temp/**",
      "**/cache/**"
    ]
  },
  "security": {
    "enableSecurityCheck": true
  },
  "tokenCount": {
    "encoding": "o200k_base"
  }
}
```

---

## 📊 MCP Server Integration

Repomix unterstützt das [Model Context Protocol (MCP)](https://modelcontextprotocol.io), wodurch KI-Assistenten direkt mit Ihrer Codebasis interagieren können.

### Installation für Claude Code
```bash
claude mcp add repomix -- npx -y repomix --mcp
```

### Verfügbare MCP-Tools
1. **pack_codebase** - Verpackt lokales Verzeichnis
2. **pack_remote_repository** - Verpackt Remote-Repository
3. **read_repomix_output** - Liest Repomix-Ausgabedatei
4. **grep_repomix_output** - Durchsucht Repomix-Ausgabe
5. **file_system_read_file** - Liest einzelne Datei mit Sicherheitscheck
6. **file_system_read_directory** - Listet Verzeichnisinhalt

---

## 🎓 Best Practices

### 1. **Start klein, dann erweitern**
```bash
# Erst Struktur analysieren
repomix --no-files

# Dann spezifische Bereiche
repomix --include "src/core/**/*"

# Schließlich alles
repomix
```

### 2. **Token-Optimierung**
```bash
# Token-Verteilung prüfen
repomix --token-count-tree 1000

# Große Dateien identifizieren und komprimieren
repomix --compress
```

### 3. **Sicherheit zuerst**
```bash
# Immer Security-Check aktivieren (Standard)
repomix

# Sicherheitsbericht überprüfen vor dem Teilen
```

### 4. **Projektspezifische Anweisungen**
Erstellen Sie eine `repomix-instruction.md` mit:
- Code-Konventionen
- Architektur-Prinzipien
- Bekannte Probleme
- Entwicklungsrichtlinien

### 5. **Regelmäßige Updates**
```bash
# Bei Verwendung von npx: immer aktuell
npx repomix@latest

# Bei globaler Installation: regelmäßig updaten
npm update -g repomix
```

---

## 🔒 Datenschutz und Sicherheit

### CLI-Tool
- **Keine Datenübertragung**: Alle Verarbeitung erfolgt lokal
- **Keine Telemetrie**: Repomix sammelt keine Nutzerdaten
- **Offline-Betrieb**: Internet nur für Installation und Remote-Repositories

### Website (repomix.com)
- **Google Analytics**: Sammelt Nutzungsstatistiken
- **Temporäre Dateien**: Werden nach Verarbeitung sofort gelöscht

### Browser Extension
- **Keine Datensammlung**: Keine Telemetrie
- **Minimale Berechtigungen**: Nur für GitHub-Button-Integration

---

## 📝 Zusammenfassung

Repomix ist das perfekte Werkzeug für:
- ✅ Komplette Code-Reviews
- ✅ KI-gestützte Refactorings
- ✅ Automatische Dokumentationsgenerierung
- ✅ Test-Generierung
- ✅ Bug-Analyse
- ✅ Sicherheits-Audits
- ✅ Performance-Optimierung
- ✅ Developer-Onboarding
- ✅ Legacy-Code-Modernisierung
- ✅ API-Design-Reviews

**Hauptvorteil:** Gibt KI-Tools vollständigen Kontext über Ihre gesamte Codebasis, wodurch präzisere und relevantere Vorschläge möglich werden.

---

## 🔗 Weitere Ressourcen

- **Offizielle Website**: [repomix.com](https://repomix.com)
- **GitHub Repository**: [github.com/yamadashy/repomix](https://github.com/yamadashy/repomix)
- **Discord Community**: [discord.gg/wNYzTwZFku](https://discord.gg/wNYzTwZFku)
- **Dokumentation**: [repomix.com/guide](https://repomix.com/guide)
- **NPM Package**: [npmjs.com/package/repomix](https://www.npmjs.com/package/repomix)

---

**Version:** 1.2.1
**Lizenz:** MIT
**Autor:** Kazuki Yamada
