---
name: analyze
description: Analisi critica di un piano tecnico, del codice esistente o di un problema prima di implementare. Usare quando l'utente dice "analizza", "verifica il piano", "cerca rischi", "trova bug" o vuole una revisione preliminare. Quarta fase del workflow feature-driven, opzionale ma consigliata per feature complesse.
---

# Analisi critica

Fase 4/9 del workflow. Trova i problemi prima che diventino costosi.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. Leggere `.claude/spec.md`, `.claude/plan.md`, `.claude/tasks.md` del progetto.
3. Analizzare su 4 assi:
   - **Correttezza**: il piano copre tutti i criteri di accettazione della spec?
   - **Impatto**: quali parti del codice esistente vengono toccate? Regressioni possibili?
   - **Sicurezza**: input non fidati, autenticazione, autorizzazione, secret, injection.
   - **Prestazioni**: query N+1, loop nested, chiamate di rete non necessarie.
4. Produrre `.claude/analysis.md` nel progetto con findings elencati, ognuno con severità (blocker/major/minor) e file:linea.
5. Se ci sono blocker, tornare a `/plan-tasks` per aggiornare il piano.

## Output atteso

`.claude/analysis.md` nel progetto con findings numerati e severità, oppure dichiarazione esplicita "nessun problema rilevato" con giustificazione.

## Regole

- Ogni finding deve avere uno scenario di fallimento concreto (input → comportamento sbagliato), non solo "potrebbe rompersi".
- Non riscrivere il piano — segnala e basta.
- Preferire pochi finding solidi a molti speculativi.
