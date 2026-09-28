---
name: plan-tasks
description: Trasformare una spec chiarita in un piano tecnico e una lista di task azionabili. Usare quando l'utente dice "pianifica", "scomponi in task", "fammi un piano di implementazione" e c'è già una spec pronta. Terza fase del workflow feature-driven, prima di implementare.
---

# Piano tecnico e task breakdown

Fase 3/9 del workflow. Da spec a lista di lavoro eseguibile.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella come riferimento metodologico.
2. Leggere `.claude/spec.md` del progetto (output della fase 01/02).
3. Ispezionare il codebase per capire architettura esistente, stack, convenzioni (Glob/Grep sui file principali).
4. Produrre `.claude/plan.md` nel progetto con: approccio tecnico, file da toccare, ordine di implementazione, rischi. Creare la cartella `.claude/` se non esiste.
5. Produrre `.claude/tasks.md` nel progetto con task numerati, ciascuno:
   - piccolo (< 2h di lavoro)
   - indipendentemente testabile
   - con criterio di "fatto" esplicito
6. Suggerire di procedere con `/analyze` per validare il piano o `/implement` per partire.

## Output atteso

- `.claude/plan.md` del progetto: approccio + rischi + ordine.
- `.claude/tasks.md` del progetto: checklist `- [ ] Task N: <descrizione> — DoD: <criterio>`.

## Regole

- Ogni task deve essere richiudibile (fatto/non fatto), non "lavora su X".
- Non stimare tempi se non richiesto: la granularità sostituisce la stima.
- Se emergono ambiguità nella spec, tornare a `/clarify`.
