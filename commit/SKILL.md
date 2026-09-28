---
name: commit
description: Creare commit ben strutturati e opzionalmente aprire una pull request per una funzionalità completata, testata ed eventualmente refactorata. Usare quando l'utente dice "committa", "fai il commit", "apri PR" a chiusura del ciclo di lavoro. Nona e ultima fase del workflow feature-driven.
---

# Commit e pull request

Fase 9/9 del workflow. Consolida il lavoro (implementazione + test + refactor) in git in modo revisionabile.

> **⚠ Output path (regola dura)**
> Tutti i file di lavoro di questa skill vanno **esclusivamente** in `.claude/` nella root del progetto:
> `.claude/spec.md`, `.claude/plan.md`, `.claude/tasks.md`, `.claude/analysis.md`, `.claude/review.md`, `.claude/test-report.md`.
> **Mai** nella root del progetto. **Mai** nella cartella della skill (`~/.claude/skills/...`).
>
> **Prima di scrivere il primo file, obbligatorio**:
> 1. Se `.claude/` non esiste nella root del progetto, crearla.
> 2. Se trovi già uno di questi file nella **root del progetto** (residuo da sessioni precedenti), **spostalo** in `.claude/` (`git mv` se tracciato, `mv` altrimenti) prima di procedere — non duplicarlo, non ignorarlo, non ricrearne una copia.
>
> Nota: dentro la cartella di questa skill esistono `plan.md`/`spec.md`/`tasks.md` — sono **template di riferimento**, si leggono ma non si toccano. I file di lavoro veri stanno solo in `.claude/` del progetto.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. Eseguire `git status` e `git diff` per capire cosa entra nel commit.
3. **Ispezionare i file staged**: cercare segreti (chiavi API, password, token), file di build, file `.env`. Se trovi qualcosa di sospetto — anche se il nome sembra innocuo — aprire il file prima di procedere.
4. Raggruppare le modifiche in commit logici. Come regola:
   - **Un commit per la feature** (implementazione + test relativi).
   - **Un commit separato per il refactor** se è stato fatto (fase 07), così la storia distingue chiaramente cambi di comportamento da cambi strutturali.
   - Mai un file solo per commit se non giustificato dal senso logico.
5. Messaggio di commit:
   - Prima riga: `<tipo>: <cosa cambia>` (max 70 caratteri). Tipi: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`.
   - Corpo: **perché**, non cosa (il diff mostra il cosa).
6. Se richiesta PR: creare con `gh pr create`, titolo conciso, corpo con Summary (bullet) + Test plan.
7. Non pushare/aprire PR senza conferma esplicita dell'utente per quel repo.

## Output atteso

Commit creati (feature + eventuale refactor separati), git tree pulito, `.claude/tasks.md` con tutti i task marcati `- [x]`, eventuale PR aperta.

## Regole

- **[GUARDRAIL SCOPE]** Prima di committare, rileggi il diff riga per riga: ogni modifica deve essere motivabile con il task richiesto. Se una riga non serve, rimuovila. Vedi `/guardrail-scope`.
- Mai `git add -A` alla cieca — nomi di file espliciti o `git status` prima.
- Mai `--no-verify`, `--force`, `reset --hard` senza richiesta esplicita.
- Se un hook pre-commit fallisce, correggere la causa e fare un **nuovo** commit, non `--amend`.
- Se il diff contiene cambi fuori scope (formatting, rename, refactor non richiesti su codice preesistente), **stopparsi**, revertirli, e ripartire.
