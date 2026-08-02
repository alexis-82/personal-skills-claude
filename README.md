# Feature-Driven Workflow — Claude Code Skills

Set di **9 skill** per Claude Code che strutturano lo sviluppo di una funzionalità in fasi discrete, dalla spec iniziale al commit finale, con un **guardrail cross-cutting** che impedisce all'AI di uscire fuori dallo scope della richiesta.

Le skill sono **stack-agnostic**: funzionano per script Python, librerie, CLI tool, servizi web, pipeline ML, app desktop, e qualunque altro tipo di software.

---

## Le 9 skill, seguire il workflow in questo ordine

| # | Skill | Ruolo | Output principale |
|---|-------|-------|-------------------|
| 01 | `spec` | Definire requisiti + Goals + **Non-Goals** | `.claude/spec.md` nel progetto |
| 02 | `clarify` | Brainstorming interattivo (stack, architettura, alternative) + risoluzione ambiguità | `spec.md` chiarito con "Decisioni prese" |
| 03 | `plan-tasks` | Piano tecnico + task breakdown | `.claude/plan.md` + `.claude/tasks.md` |
| 04 | `analyze` | Analisi critica del piano | `.claude/analysis.md` |
| 05 | `implement` | Scrivere il codice | Codice + `.claude/tasks.md` aggiornato |
| 06 | `test` | Test contro criteri di accettazione | Suite verde |
| 07 | `refactor` | Pulire con i test come rete di sicurezza | Codice più leggibile, comportamento invariato |
| 08 | `commit` | Commit strutturati + eventuale PR | Storia git pulita |
| ⚠ | `guardrail-scope` | Cross-cutting: Guardarail AI | — |

Ordine tipico: `spec → clarify → plan-tasks → (analyze) → implement → test → (refactor) → commit`. Le fasi `analyze` e `refactor` sono opzionali.

---

## Concetti chiave

### Goals / Non-Goals

Ogni `.claude/spec.md` contiene due sezioni obbligatorie:

- **Goals** — 3-7 bullet verificabili con cosa la feature **deve** fare.
- **Non-Goals** — 3-7 bullet con cosa la feature **NON** deve fare, esplicitamente.

I **Non-Goals** sono il contratto che l'utente firma con l'AI in fase 01. Vengono riletti dalle fasi successive prima di ogni modifica e servono a prevenire scope creep.

Esempio (script Python di analisi):

```markdown
## Goals
- [ ] Leggere CSV da ./in/, calcolare medie mensili, salvare in ./out/report.csv

## Non-Goals
- [ ] NON parallelizzare il calcolo
- [ ] NON persistere su DB
- [ ] NON aggiungere plot/grafici
```

Il file `spec/spec.md` (template nella cartella della skill) contiene esempi di Non-Goals per: script Python, librerie, CLI, servizi backend, pipeline ML, app desktop.

### Guardrail: disciplina dello scope

`guardrail-scope` è una skill trasversale che vincola l'AI a modificare **solo** il codice strettamente necessario alla richiesta. Regole:

1. **Check n°1** — se esiste `.claude/spec.md` con Non-Goals, quelli sono la fonte di verità prioritaria.
2. **Check n°2** — anche in loro assenza, no pulizie opportunistiche, no riformattazioni, no rinomine collaterali, no refactor spontanei.
3. **Auto-verifica pre-commit** — ogni riga del diff deve essere motivabile con il task richiesto. Se no, va rimossa.

Se durante il lavoro emergono problemi fuori scope, l'AI li **segnala** ma non li risolve senza autorizzazione.

---

## Installazione

Le skill vanno installate in `~/.claude/skills/` (su Windows: `C:\Users\<utente>\.claude\skills\`). Nel repo trovi due script che copiano le 9 cartelle nella destinazione, sovrascrivendo eventuali versioni precedenti con lo stesso nome.

### Windows (PowerShell)

```powershell
.\install.ps1
```

Se PowerShell blocca l'esecuzione con un errore di execution policy, sbloccalo solo per questa sessione:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\install.ps1
```

### Linux / macOS (bash)

```bash
./install.sh
```

Se serve, rendi lo script eseguibile una volta sola: `chmod +x install.sh`.

### Cosa fanno gli script

- Creano `~/.claude/skills/` se manca.
- Copiano le 9 skill (`spec`, `clarify`, `plan-tasks`, `analyze`, `implement`, `test`, `refactor`, `commit`, `guardrail-scope`), sovrascrivendo eventuali versioni precedenti con lo stesso nome.
- Al termine, riavvia Claude Code per caricare le skill aggiornate.

Ogni cartella skill contiene:
- `SKILL.md` — istruzioni per l'AI (con frontmatter YAML)
- `plan.md`, `spec.md`, `tasks.md` — template e checklist di supporto (dove applicabile)

---

## Come si usano

### Invocazione esplicita

Digita lo slash command:

```
/spec
/implement
/guardrail-scope
```

### Attivazione automatica

Le skill si attivano da sole in base al `description` YAML. Frasi che le triggerano:

| Se dici… | Si attiva… |
|----------|------------|
| "definisci i requisiti", "scrivi la spec" | `spec` |
| "chiarisci", "cosa manca", "brainstorma", "esploriamo le opzioni", "quale stack" | `clarify` |
| "pianifica", "scomponi in task" | `plan-tasks` |
| "analizza", "verifica il piano" | `analyze` |
| "implementa", "scrivi il codice" | `implement` |
| "testa", "scrivi i test" | `test` |
| "refactora", "pulisci il codice" | `refactor` |
| "committa", "apri PR" | `commit` |
| "attenzione allo scope", "lavora sui binari" | `guardrail-scope` |

---

## Esempio di flusso completo

Immagina di dover aggiungere un endpoint di export in un servizio Python esistente.

```
> /spec voglio esportare gli utenti in CSV via endpoint GET /users/export

[AI compila spec.md con Goals + Non-Goals + interfaccia + criteri]

> ok procedi

> /clarify

[AI apre un brainstorming: presenta 2-4 alternative per i punti decisionali
 (es. formato CSV via streaming vs in-memory, autenticazione richiesta o no,
 paginazione o dump completo) con pro/contro concreti, chiede a te di scegliere.
 Poi 2-3 domande chiuse per le ambiguità puntuali e propone Non-Goals aggiuntivi.
 Aggiunge la sezione "Decisioni prese" a spec.md]

> /plan-tasks

[AI ispeziona il codebase, produce .claude/plan.md e .claude/tasks.md con 4 task]

> /implement

[AI implementa task 1..4, tenendo d'occhio i Non-Goals; se emerge un problema fuori scope, lo segnala]

> /test

[AI scrive test per ogni criterio di accettazione, verifica suite verde]

> /refactor  (opzionale)

[AI pulisce solo il codice appena scritto, non tocca il resto]

> /commit

[AI rilegge il diff riga per riga, propone commit separati per feature e refactor]
```

In qualunque momento puoi dire **"attenzione allo scope"** per invocare esplicitamente `guardrail-scope` come promemoria.

---

## Struttura file

```
skills/
├── README.md                    # questo file
├── spec/
│   ├── SKILL.md                 # istruzioni AI
│   ├── plan.md                  # metodo
│   ├── spec.md                  # template output (con esempi Non-Goals per stack)
│   └── tasks.md                 # checklist
├── clarify/
├── plan-tasks/
├── analyze/
├── implement/
├── test/
├── refactor/
├── commit/
└── guardrail-scope/
    └── SKILL.md
```

---

## Personalizzazione

- **Vocabolario**: adatta i termini della `spec.md` al tuo dominio. Il template è neutro (parla di "consumatori", "interfaccia", "unità di codice") — sostituisci con "endpoint", "comando", "modulo", "componente", ecc. secondo il progetto.
- **Fasi**: se non ti serve una fase (es. analisi o refactor), saltala. Il workflow non è rigido.
- **Non-Goals per stack**: `spec/spec.md` ha esempi per 6 tipi di software; aggiungi i tuoi se lavori su domini ricorrenti (embedded, mobile, ecc.).
- **Memoria persistente**: il guardrail è già registrato nel sistema di memoria di Claude Code, quindi si applica **in tutte le sessioni**, anche fuori da questo workflow.

---

## Note

- Le skill sono in italiano ma il codice generato segue le convenzioni del progetto (inglese se il codebase è in inglese).
- I file `plan.md` / `tasks.md` nelle cartelle skill sono **template di riferimento**, non vengono modificati durante l'uso. I file di lavoro veri vivono nel progetto sotto `.claude/` (`spec.md`, `plan.md`, `tasks.md`, `analysis.md` e l'eventuale `test-report.md`).
- La skill `guardrail-scope` è pensata anche per essere invocata fuori dal workflow feature-driven, in qualunque task che tocchi codice.
