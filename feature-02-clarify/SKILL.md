---
name: feature-02-clarify
description: Risolvere ambiguità e domande aperte in una spec esistente. Usare quando l'utente dice "chiarisci", "questa spec è vaga", "cosa manca", o quando `spec.md` contiene marker `[?]` / TODO / punti ambigui. Seconda fase del workflow feature-driven, tra feature-01-spec e feature-03-plan-tasks.
---

# Chiarimento requisiti

Fase 2/8 del workflow. Elimina l'ambiguità prima di pianificare.

## Cosa fare

1. Leggere `plan.md`, `spec.md` (template), `tasks.md` (checklist) di questa cartella.
2. Aprire `spec.md` del progetto e identificare: marker `[?]`, TODO, frasi vaghe ("gestire correttamente", "ottimizzato", "user-friendly"), assunzioni non dichiarate.
3. Per ogni ambiguità formulare **una** domanda chiusa (sì/no o opzioni multiple) — mai domande aperte a cascata. Usare `AskUserQuestion`.
4. Verificare che la sezione **Non-Goals** esista e sia specifica. Se manca o è vaga, proporre 3-5 Non-Goals candidati dedotti dal contesto e chiedere conferma — è il momento giusto per fissare i binari, prima che l'implementazione parta.
5. Aggiornare `spec.md` del progetto con le risposte e rimuovere i marker risolti.
6. Se restano ambiguità che l'utente non può risolvere ora, marcarle come `[?risolvere-dopo: <motivo>]`.

## Output atteso

`spec.md` senza `[?]` non risolti, con una sezione "Decisioni prese" che elenca le scelte fatte con motivazione breve.

## Regole

- Massimo 4 domande per turno per non affaticare l'utente.
- Non riscrivere la spec da zero — modifica chirurgica.
- Se la spec è già chiara, dichiararlo esplicitamente e passare a `/skill:feature-03-plan-tasks`.
