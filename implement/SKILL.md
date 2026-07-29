---
name: implement
description: Implementare la funzionalità seguendo un piano e una task list già definiti. Usare quando l'utente dice "implementa", "scrivi il codice", "esegui i task" o simili, e esistono già plan.md/tasks.md nel progetto. Quinta fase del workflow feature-driven.
---

# Implementazione

Fase 5/8 del workflow. Da piano a codice funzionante.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. Leggere `plan.md`, `tasks.md` **e le sezioni Goals/Non-Goals di `spec.md`** del progetto. Tenere i Non-Goals in mente come lista di "vietato".
3. Per ogni task in ordine:
   - Marcarlo `in_progress`.
   - Implementare la modifica minima che soddisfa il DoD.
   - Verificare rapidamente (compilazione/lint/test unitario mirato) prima di passare al successivo.
   - Marcarlo `done` in `tasks.md`.
4. Se un task rivela che il piano è sbagliato: **fermarsi**, aggiornare il piano, non improvvisare.
5. Al termine, suggerire `/skill:test` per la validazione completa.

## Output atteso

Codice implementato + `tasks.md` aggiornato con task completati marcati `- [x]`.

## Regole

- **[GUARDRAIL SCOPE]** Modifica solo il codice strettamente necessario al task. Niente pulizie opportunistiche, riformattazioni, rinomine o refactor non richiesti. Vedi `/skill:guardrail-scope`.
- **[NON-GOALS]** Prima di ogni modifica, verificare che non violi un Non-Goal dichiarato in `spec.md`. Se un task ti sta portando a violare un Non-Goal, **fermati** e segnalalo — probabilmente il piano ha un problema.
- Un task alla volta — no batch di modifiche non correlate.
- No feature extra oltre spec: se serve qualcosa fuori scope, aggiungerlo come nuovo task, non implementarlo di nascosto.
- Preferire modificare file esistenti a crearne di nuovi.
- Se un test esistente si rompe per una modifica non voluta, capire perché prima di "aggiustarlo".
- Se trovi un problema fuori scope: **segnalalo**, non risolverlo.
