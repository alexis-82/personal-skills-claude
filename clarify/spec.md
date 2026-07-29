# Documentazione del Chiarimento

Template per la sezione che verrà aggiunta a `spec.md` del progetto dopo la fase clarify.

## Punti Decisionali Esplorati
Elenca i temi affrontati in brainstorming (anche solo per dichiarare che sono stati considerati):

- [ ] Stack tecnico
- [ ] Persistenza / storage
- [ ] Architettura / concorrenza
- [ ] Modello dati
- [ ] Interfaccia esposta
- [ ] Gestione errori
- [ ] Strategia di testing
- [ ] Deploy / esecuzione
- [ ] Altro: _______

## Decisioni Prese
Per ciascuna decisione documentare: **cosa**, **alternative valutate**, **motivazione** (1-2 righe).

Esempio:
- **Persistenza** → SQLite. Alternative: Postgres, file JSON. Motivazione: single-user, no concorrenza, evita dipendenza esterna e semplifica il deploy.
- **Concorrenza** → sync + thread pool. Alternative: `asyncio`, worker con queue. Motivazione: I/O limitato a 2-3 chiamate parallele, non giustifica la complessità di async.
- **Interfaccia** → CLI `argparse`. Alternative: `click`, `typer`. Motivazione: zero dipendenze extra, gli utenti target non richiedono UX avanzata.

## Ambiguità Risolte
- [ ] Storia utente #N chiarita
- [ ] Criterio di accettazione X reso verificabile
- [ ] Vincolo tecnico Y confermato

## Ambiguità Residue
- [ ] `[?risolvere-dopo: <motivo>]` — quando/come deciderlo

## Non-Goals Confermati
- [ ] NON _funzionalità specifica_
- [ ] NON _comportamento specifico_
- [ ] NON _modificare X anche se emerge Y_
