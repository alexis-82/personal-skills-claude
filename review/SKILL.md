---
name: review
description: Revisione critica del codice appena implementato — correttezza, edge case, sicurezza, prestazioni, leggibilità — con findings elencati per severità. Usare quando l'utente dice "revisiona", "code review", "cerca bug nel codice", "controlla la qualità", "trova problemi", tipicamente dopo che i test sono verdi e prima di refactor/commit. Settima fase del workflow feature-driven, opzionale ma consigliata.
---

# Code Review

Fase 7/9 del workflow. Trova problemi nel **codice implementato** prima che finiscano in un commit.

## Differenza con `analyze` (fase 04)

- `analyze` esamina il **piano** prima dell'implementazione — ipotesi su cosa potrebbe andare storto.
- `review` esamina il **codice scritto** dopo test verdi — problemi reali che i test non catturano (leggibilità, edge case non testati, sicurezza, prestazioni sottili).

Sono complementari, non alternative.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. Leggere `.claude/spec.md` (Goals, Non-Goals, criteri di accettazione) e `.claude/plan.md` del progetto.
3. Recuperare il diff del lavoro corrente (git diff sui file toccati dall'implementazione, o l'elenco dei file modificati in `.claude/tasks.md`).
4. Analizzare il codice su **5 assi**:
   - **Correttezza**: la logica soddisfa i criteri di accettazione? Ci sono branch non esercitati? Off-by-one, condizioni invertite, null/undefined non gestiti?
   - **Edge case non coperti**: input vuoti, valori limite, encoding, timezone, precisione numerica, concorrenza, ordini di esecuzione — casi che i test attuali non toccano.
   - **Sicurezza**: input non fidati, injection (SQL/command/path), secret hardcoded, autenticazione/autorizzazione mancanti, escaping, deserializzazione insicura.
   - **Prestazioni**: query N+1, loop nested inutili, chiamate di rete ripetute, allocazioni evitabili nel caldo, blocking I/O in path sincroni.
   - **Leggibilità / manutenibilità**: naming ambiguo, funzioni troppo lunghe, duplicazione, commenti che raccontano il "cosa" invece del "perché", firma poco chiara, abstraction leak.
5. Produrre `.claude/review.md` nel progetto con findings numerati, ciascuno con:
   - **Severità**: `blocker` (rompe la feature o è un rischio sicurezza) / `major` (bug sottile o problema di correttezza che sfuggirà ai test) / `minor` (leggibilità, stile, refactor consigliato).
   - **Locazione**: `file:linea` esatta.
   - **Scenario di fallimento** (per blocker/major): input concreto → comportamento sbagliato.
   - **Suggerimento**: una frase con la direzione della fix, non il codice completo.
6. Al termine, in base ai findings:
   - Se ci sono **blocker o major**: tornare a `/implement` per correggerli, poi rilanciare `/test`.
   - Se ci sono solo **minor** di natura strutturale (duplicazione, naming, funzioni lunghe): passare a `/refactor`.
   - Se non ci sono findings: passare direttamente a `/commit`.

## Output atteso

`.claude/review.md` nel progetto con findings numerati per severità decrescente, oppure dichiarazione esplicita "nessun problema rilevato" con una riga per ognuno dei 5 assi che spieghi perché.

## Regole

- **[GUARDRAIL SCOPE]** Revisiona **solo** il codice modificato/aggiunto dall'implementazione corrente, non il resto del codebase. Se noti problemi in codice preesistente non toccato, elencali in una sezione separata "Fuori scope — segnalazioni" senza suggerire di risolverli in questo ciclo. Vedi `/guardrail-scope`.
- **[NON-GOALS]** I Non-Goals di `.claude/spec.md` valgono anche in review: non trattare come "problema" qualcosa che è esplicitamente dichiarato fuori scope (es. "NON parallelizzare" non è un finding di prestazioni).
- Ogni finding **blocker** e **major** deve avere uno scenario di fallimento concreto (input → output sbagliato), non speculazioni tipo "potrebbe rompersi".
- Preferire **pochi finding solidi** a molti speculativi. Meglio 3 problemi certi che 15 ipotesi.
- Non riscrivere il codice in questa fase — segnala e basta. Le fix vanno in `/implement` o `/refactor`.
- Se un finding richiede di violare un Non-Goal per essere risolto, dichiararlo esplicitamente: la risoluzione va rimandata a una spec successiva, non fatta di nascosto.
- La review è **critica ma costruttiva**: obiettivo è consegnare codice migliore, non elencare colpe.
