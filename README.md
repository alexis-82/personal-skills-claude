# Feature-Driven Workflow — Claude Code Skills

Set di **9 skill** per Claude Code che strutturano lo sviluppo di una funzionalità in fasi discrete, dalla spec iniziale al commit finale, con un **guardrail cross-cutting** che impedisce all'AI di uscire fuori dallo scope della richiesta.

Le skill sono **stack-agnostic**: funzionano per script Python, librerie, CLI tool, servizi web, pipeline ML, app desktop, e qualunque altro tipo di software.

---

## Le 9 skill

| # | Skill | Ruolo | Output principale |
|---|-------|-------|-------------------|
| 01 | `feature-01-spec` | Definire requisiti + Goals + **Non-Goals** | `spec.md` nel progetto |
| 02 | `feature-02-clarify` | Risolvere ambiguità nella spec | `spec.md` chiarito |
| 03 | `feature-03-plan-tasks` | Piano tecnico + task breakdown | `plan.md` + `tasks.md` |
| 04 | `feature-04-analyze` | Analisi critica del piano | `analysis.md` |
| 05 | `feature-05-implement` | Scrivere il codice | Codice + `tasks.md` aggiornato |
| 06 | `feature-06-test` | Test contro criteri di accettazione | Suite verde |
| 07 | `feature-07-refactor` | Pulire con i test come rete di sicurezza | Codice più leggibile, comportamento invariato |
| 08 | `feature-08-commit` | Commit strutturati + eventuale PR | Storia git pulita |
| ⚠ | `guardrail-scope` | Cross-cutting: Guardarail AI | — |

Ordine tipico: `01 → 02 → 03 → (04) → 05 → 06 → (07) → 08`. Le fasi 04 e 07 sono opzionali.

---

## Concetti chiave

### Goals / Non-Goals

Ogni `spec.md` contiene due sezioni obbligatorie:

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

Il file `feature-01-spec/spec.md` contiene esempi di Non-Goals per: script Python, librerie, CLI, servizi backend, pipeline ML, app desktop.

### Guardrail: disciplina dello scope

`guardrail-scope` è una skill trasversale che vincola l'AI a modificare **solo** il codice strettamente necessario alla richiesta. Regole:

1. **Check n°1** — se esiste `spec.md` con Non-Goals, quelli sono la fonte di verità prioritaria.
2. **Check n°2** — anche in loro assenza, no pulizie opportunistiche, no riformattazioni, no rinomine collaterali, no refactor spontanei.
3. **Auto-verifica pre-commit** — ogni riga del diff deve essere motivabile con il task richiesto. Se no, va rimossa.

Se durante il lavoro emergono problemi fuori scope, l'AI li **segnala** ma non li risolve senza autorizzazione.

---

## Installazione

Le skill sono già installate in `~/.claude/skills/` (per te: `C:\Users\Alessio\.claude\skills\`).

Per reinstallare o installare in un altro ambiente:

```bash
cp -r feature-01-spec feature-02-clarify feature-03-plan-tasks \
      feature-04-analyze feature-05-implement feature-06-test \
      feature-07-refactor feature-08-commit guardrail-scope \
      ~/.claude/skills/
```

Ogni cartella contiene:
- `SKILL.md` — istruzioni per l'AI (con frontmatter YAML)
- `plan.md`, `spec.md`, `tasks.md` — template e checklist di supporto

---

## Come si usano

### Invocazione esplicita

Digita lo slash command:

```
/feature-01-spec
/feature-05-implement
/guardrail-scope
```

### Attivazione automatica

Le skill si attivano da sole in base al `description` YAML. Frasi che le triggerano:

| Se dici… | Si attiva… |
|----------|------------|
| "definisci i requisiti", "scrivi la spec" | `feature-01-spec` |
| "chiarisci", "cosa manca" | `feature-02-clarify` |
| "pianifica", "scomponi in task" | `feature-03-plan-tasks` |
| "analizza", "verifica il piano" | `feature-04-analyze` |
| "implementa", "scrivi il codice" | `feature-05-implement` |
| "testa", "scrivi i test" | `feature-06-test` |
| "refactora", "pulisci il codice" | `feature-07-refactor` |
| "committa", "apri PR" | `feature-08-commit` |
| "attenzione allo scope", "lavora sui binari" | `guardrail-scope` |

---

## Esempio di flusso completo

Immagina di dover aggiungere un endpoint di export in un servizio Python esistente.

```
> /feature-01-spec voglio esportare gli utenti in CSV via endpoint GET /users/export

[AI compila spec.md con Goals + Non-Goals + interfaccia + criteri]

> ok procedi

> /feature-02-clarify

[AI ti fa 2-3 domande chiuse per risolvere ambiguità e propone Non-Goals aggiuntivi]

> /feature-03-plan-tasks

[AI ispeziona il codebase, produce plan.md e tasks.md con 4 task]

> /feature-05-implement

[AI implementa task 1..4, tenendo d'occhio i Non-Goals; se emerge un problema fuori scope, lo segnala]

> /feature-06-test

[AI scrive test per ogni criterio di accettazione, verifica suite verde]

> /feature-07-refactor  (opzionale)

[AI pulisce solo il codice appena scritto, non tocca il resto]

> /feature-08-commit

[AI rilegge il diff riga per riga, propone commit separati per feature e refactor]
```

In qualunque momento puoi dire **"attenzione allo scope"** per invocare esplicitamente `guardrail-scope` come promemoria.

---

## Struttura file

```
skills/
├── README.md                    # questo file
├── skills.txt                   # elenco skill
├── script.py                    # generatore originale (legacy)
├── feature-01-spec/
│   ├── SKILL.md                 # istruzioni AI
│   ├── plan.md                  # metodo
│   ├── spec.md                  # template output (con esempi Non-Goals per stack)
│   └── tasks.md                 # checklist
├── feature-02-clarify/
├── feature-03-plan-tasks/
├── feature-04-analyze/
├── feature-05-implement/
├── feature-06-test/
├── feature-07-refactor/
├── feature-08-commit/
└── guardrail-scope/
    └── SKILL.md
```

---

## Personalizzazione

- **Vocabolario**: adatta i termini della `spec.md` al tuo dominio. Il template è neutro (parla di "consumatori", "interfaccia", "unità di codice") — sostituisci con "endpoint", "comando", "modulo", "componente", ecc. secondo il progetto.
- **Fasi**: se non ti serve una fase (es. analisi o refactor), saltala. Il workflow non è rigido.
- **Non-Goals per stack**: `feature-01-spec/spec.md` ha esempi per 6 tipi di software; aggiungi i tuoi se lavori su domini ricorrenti (embedded, mobile, ecc.).
- **Memoria persistente**: il guardrail è già registrato nel sistema di memoria di Claude Code, quindi si applica **in tutte le sessioni**, anche fuori da questo workflow.

---

## Note

- Le skill sono in italiano ma il codice generato segue le convenzioni del progetto (inglese se il codebase è in inglese).
- I file `plan.md` / `tasks.md` nelle cartelle skill sono **template di riferimento**, non vengono modificati durante l'uso. I file di lavoro veri vivono nella cartella del progetto.
- La skill `guardrail-scope` è pensata anche per essere invocata fuori dal workflow feature-driven, in qualunque task che tocchi codice.
