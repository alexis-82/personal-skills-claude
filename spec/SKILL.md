---
name: spec
description: Definire la specifica di una nuova funzionalità partendo da un'idea o richiesta grezza, con Goals e Non-Goals espliciti. Usare quando l'utente vuole "specificare", "definire i requisiti", "scrivere la spec" o "documentare cosa fare" prima di iniziare a sviluppare. Prima fase del workflow feature-driven.
---

# Specifica funzionalità

Fase 1/8 del workflow. Trasforma un'idea in una specifica azionabile con confini chiari.

## Cosa fare

1. Leggere `plan.md` per il metodo, `spec.md` come template di output, `tasks.md` per la checklist operativa.
2. Chiedere all'utente (o dedurre dal contesto) chi sono gli utenti, cosa devono ottenere e con quali vincoli.
3. Compilare `.claude/spec.md` nella cartella del progetto (non in questa cartella skill, non nella root). Creare la cartella `.claude/` se non esiste. Il file deve contenere **tutte** le sezioni sotto, incluse Goals e Non-Goals.
4. Rileggere Non-Goals con l'utente prima di procedere — è la sezione più importante per prevenire scope creep.
5. Al termine, suggerire di passare a `/skill:clarify` se restano ambiguità, altrimenti a `/skill:plan-tasks`.

## Output atteso

Un file `.claude/spec.md` nel progetto con queste sezioni **obbligatorie**:

- **Obiettivo** — una frase che riassume perché questa feature esiste.
- **Goals** — 3-7 bullet con cosa la feature **deve** fare. Ogni goal deve essere verificabile (superato/fallito), non aspirazionale.
- **Non-Goals** — 3-7 bullet con cosa la feature **non deve** fare, esplicitamente. Include: funzionalità correlate ma escluse, casi d'uso non supportati, ottimizzazioni non richieste, refactor collaterali. Serve a delimitare lo scope in modo hard.
- **User stories** — `Come <ruolo>, voglio <azione>, per <beneficio>`.
- **Criteri di accettazione** — condizioni oggettive per dichiarare la feature "fatta".
- **Vincoli tecnici** — stack, compatibilità, performance, sicurezza.
- **Ambiguità aperte** — marcate `[?]`, da risolvere in fase 02.

## Come scrivere i Non-Goals

Un buon Non-Goal è **specifico** e **plausibile** — descrive qualcosa che qualcuno *potrebbe pensare* sia incluso ma non lo è. Il file `spec.md` di questa cartella contiene una sezione **"Esempi di Non-Goals per tipo di software"** con casi per script Python, librerie, CLI, servizi, pipeline ML, app desktop. Usali come punto di partenza calibrato al progetto corrente.

Forma generale di un buon Non-Goal:
- "**NON** _funzionalità/comportamento specifico_" (verificabile a colpo d'occhio)
- oppure "**NON** _modificare X_ anche se durante il lavoro emerge Y" (blocca scope creep)

Non-Goal **cattivo** (troppo vago, non azionabile): "non fare cose fuori scope", "non introdurre bug", "non peggiorare le performance".

## Adattare il vocabolario al progetto

Questa skill funziona per **qualunque tipo di software**. Adatta il vocabolario a ciò che stai costruendo:

- **Script / analisi dati**: "input", "output", "step della pipeline"
- **Libreria / modulo**: "funzioni pubbliche", "classi esposte", "API della libreria"
- **CLI tool**: "comandi", "flag", "formato input/output"
- **Servizio / backend**: "endpoint", "messaggi", "schema"
- **App desktop / frontend**: "schermate", "componenti", "flussi utente"
- **Pipeline ML / ETL**: "step", "artefatti", "dataset"

Il template `spec.md` non impone un vocabolario — usa quello del tuo dominio.

## Regole

- Non implementare nulla in questa fase.
- Non decidere lo stack tecnico se non è già vincolato — questo è compito di `plan-tasks`.
- Se qualcosa è ambiguo, marcarlo con `[?]` invece di inventare.
- La spec **non** è completa se manca la sezione Non-Goals — è un errore comune saltarla e porta a scope creep in fase di implementazione.
- Se l'utente non sa cosa sono i Non-Goals, proporne 3 candidati dedotti dal contesto e chiedere conferma.
