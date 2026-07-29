---
name: clarify
description: Chiarire una spec attraverso un dialogo di brainstorming con lo sviluppatore — esplorare alternative tecniche, stack, architettura, approcci e trade-off, poi risolvere le ambiguità residue. Usare quando l'utente dice "chiarisci", "brainstorma", "esploriamo le opzioni", "quale stack usare", "quali alternative", "cosa manca", "questa spec è vaga", o quando `spec.md` contiene marker `[?]` / TODO / punti ambigui. Seconda fase del workflow feature-driven, tra spec e plan-tasks.
---

# Chiarimento requisiti + Brainstorming

Fase 2/8 del workflow. Due obiettivi intrecciati:

1. **Brainstorming** — dialogo aperto e bidirezionale per esplorare alternative (stack, architettura, approcci, trade-off) prima che qualunque decisione venga cementata nel piano.
2. **Convergenza** — trasformare le esplorazioni in decisioni scritte e risolvere le ambiguità puntuali residue.

Il brainstorming **non è opzionale**: anche se la spec sembra chiara, ci sono quasi sempre decisioni progettuali (stack, storage, algoritmo, pattern, boundary di responsabilità) che meritano di essere messe sul tavolo prima di pianificare i task. Saltare questa fase porta a decisioni implicite fatte in solitudine dall'AI durante l'implementazione — con costi alti per revertirle dopo.

## Cosa fare

### Fase A — Analisi (silenziosa)

1. Leggere `plan.md`, `spec.md` (template), `tasks.md` (checklist) di questa cartella.
2. Aprire `spec.md` del progetto e ispezionare rapidamente il codebase (stack esistente, convenzioni, dipendenze già presenti) per capire i vincoli reali.
3. Identificare **due categorie** di punti aperti:
   - **Ambiguità puntuali**: marker `[?]`, TODO, frasi vaghe ("gestire correttamente", "ottimizzato", "user-friendly"), assunzioni non dichiarate.
   - **Punti decisionali**: scelte con più soluzioni valide che la spec non ha ancora vincolato — es. quale libreria/framework, quale storage, quale pattern architetturale, come modellare i dati, dove tracciare i confini di responsabilità, come gestire concorrenza/errori, quale strategia di test.

### Fase B — Brainstorming (obbligatoria, interattiva)

4. Per ogni **punto decisionale** significativo aprire un dialogo diretto con lo sviluppatore. Il formato è:
   - **Contesto in una riga**: perché questa decisione conta, quali vincoli visibili già la limitano.
   - **2-4 alternative concrete e nominate**: non "opzione A vs opzione B" generiche — soluzioni riconoscibili tipo "SQLite vs Postgres vs file JSON", "async con `asyncio` vs sync + thread pool", "modulo dentro il monolite esistente vs microservizio separato".
   - **Per ciascuna alternativa**: `pro` (1-2 bullet concreti), `contro` (1-2 bullet concreti), `quando conviene` (una riga).
   - **Raccomandazione**: se una ti sembra più adatta al contesto, dichiaralo esplicitamente con la motivazione — non nascondere l'opinione, ma non imporla.
   - **Domanda focalizzata** con `AskUserQuestion` presentando le alternative come opzioni. Lascia sempre lo spazio a una quinta strada proposta dallo sviluppatore.

5. Se lo sviluppatore propone un'alternativa non nella lista, **discuterla**: pro/contro con la stessa struttura, poi confronto con le altre. Il brainstorming è bidirezionale, non un menu chiuso.

**Temi da coprire in brainstorming** (quando applicabili al progetto):

- **Stack tecnico**: linguaggio, framework, librerie chiave, versioni.
- **Persistenza**: DB relazionale, NoSQL, file, in-memory, cache layer, formato.
- **Architettura / concorrenza**: sync/async, worker/queue, batch/streaming, monolite/modulare, event-driven.
- **Modello dati**: schema, relazioni, denormalizzazione, invarianti, migrazioni.
- **Interfaccia esposta**: CLI/HTTP/libreria/UI; formato input/output; contratto pubblico.
- **Gestione errori**: fail-fast vs graceful degradation, retry, idempotenza, dead letter.
- **Testing**: livelli (unit/integration/e2e), fixture vs mock, container di test.
- **Deploy / esecuzione**: locale, container, serverless, cron, on-demand, distribuzione.
- **Osservabilità**: logging, metrics, tracing — livello opportuno per lo scope.

Non serve toccarli tutti — solo quelli **realmente aperti** per questa feature. Se la spec dice già "usa Postgres esistente", non ribrainstormare la persistenza.

### Fase C — Convergenza e scrittura

6. Per ogni **ambiguità puntuale** residua (non decisionale) formulare **una** domanda chiusa (sì/no o opzioni multiple) — mai domande aperte a cascata. Usare `AskUserQuestion`.
7. Verificare che la sezione **Non-Goals** esista e sia specifica. Se manca o è vaga, proporre 3-5 Non-Goals candidati dedotti dal contesto e dalle decisioni prese in brainstorming, e chiedere conferma — è il momento giusto per fissare i binari.
8. Aggiornare `spec.md` del progetto con:
   - Nuova sezione **"Decisioni prese"** con: decisione, alternative valutate, motivazione (1-2 righe).
   - Risposte alle domande e rimozione dei marker `[?]` risolti.
   - Non-Goals confermati/aggiunti.
9. Se restano ambiguità non risolvibili ora, marcarle come `[?risolvere-dopo: <motivo>]`.

## Output atteso

`spec.md` del progetto con:
- Nessun marker `[?]` non risolto (o marcato esplicitamente `[?risolvere-dopo]`).
- Sezione **"Decisioni prese"** che documenta le scelte fatte in brainstorming, con motivazione breve e alternative scartate.
- Non-Goals specifici e confermati.

## Regole

- **Il brainstorming è obbligatorio** — anche se sembra che "sia tutto chiaro", cerca almeno un punto decisionale (stack, modello dati, boundary, gestione errori) da mettere sul tavolo. Se davvero non ce n'è (spec pre-chiusa dallo sviluppatore), dichiararlo esplicitamente prima di procedere.
- **Massimo 4 domande per turno** — se ci sono molti punti decisionali, iterare su turni multipli piuttosto che sommergere lo sviluppatore.
- **Pro/contro concreti**, non generici: "più veloce" senza dire quanto ≠ utile; "più semplice" senza dire in cosa ≠ utile. Cita numeri, dipendenze, righe di codice, LoE indicativo quando possibile.
- **Non decidere per l'utente**: proponi, valuta insieme, poi scrivi la scelta. Ma non essere neutro se hai un'opinione — dichiarala.
- **Il brainstorming è divergente prima di essere convergente**: mostra le alternative *prima* di eleggere una vincitrice, anche quando hai già in mente la risposta.
- **Non riscrivere la spec da zero** — modifica chirurgica, aggiungendo la sezione "Decisioni prese".
- Se emergono ambiguità che cambiano la spec di fondo (Goals rivisti, scope allargato), tornare a `/skill:spec`.
- Se la spec è genuinamente chiusa e tutte le decisioni sono già state prese esplicitamente, dichiararlo e passare a `/skill:plan-tasks`.
