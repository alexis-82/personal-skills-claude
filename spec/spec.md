# Specifica della Funzionalità

> Template neutro rispetto al tipo di software. Vale per script, CLI, librerie, servizi, pipeline, app desktop, ML, ecc. Adatta il vocabolario al tuo contesto (es. "endpoint" per un servizio, "comando" per una CLI, "funzione pubblica" per una libreria, "step della pipeline" per un ETL).

## Obiettivo

_Una frase: perché questa feature esiste e quale problema risolve._

## Goals (cosa DEVE fare)

_3-7 bullet verificabili, non aspirazionali. Ogni Goal è superato/fallito._

- [ ] Goal 1: _..._
- [ ] Goal 2: _..._
- [ ] Goal 3: _..._

## Non-Goals (cosa NON deve fare) — scope hard

> Ogni Non-Goal è un binario che l'AI non deve attraversare senza autorizzazione esplicita.
> Adatta gli esempi al tuo contesto — vedi la sezione "Esempi per tipo di software" più sotto.

- [ ] NON _funzionalità correlata ma esplicitamente esclusa_
- [ ] NON _caso d'uso non supportato in questa iterazione_
- [ ] NON _ottimizzazione/refactor collaterale non richiesto_
- [ ] NON _modifica a file/modulo/area al di fuori dei confini dichiarati_

## Utenti / consumatori

_Chi userà questa funzionalità? Un utente finale? Un altro script? Un'altra funzione? Un'altra parte del sistema? Definire il consumatore aiuta a dimensionare l'interfaccia._

## Interfaccia

_Come si invoca / come si consuma. Adatta al tipo di software:_
- _Libreria/modulo: firme di funzioni/classi pubbliche_
- _CLI: comandi, flag, formato input/output_
- _Servizio: endpoint, formato messaggi_
- _Script/pipeline: input attesi, output prodotti, formato dei dati_
- _App: schermate/flussi interessati_

## Criteri di accettazione

_Condizioni oggettive per dichiarare la feature "fatta"._

- [ ] Criterio 1: _dato input X, output Y_
- [ ] Criterio 2: _in condizione Z il comportamento è W_

## Vincoli tecnici

- Stack / linguaggio / versioni: _..._
- Compatibilità: _..._
- Performance: _..._ (se rilevante)
- Sicurezza: _..._ (se rilevante)
- Ambiente di esecuzione: _..._ (se rilevante)

## Ambiguità aperte

- [?] _domanda da chiarire in clarify_

---

## Esempi di Non-Goals per tipo di software

**Script Python di analisi dati:**
- NON persistere risultati su DB — l'output resta CSV in `./out/`.
- NON parallelizzare il calcolo anche se emergono lentezze.
- NON aggiungere validazione avanzata dei dati di input oltre schema base.

**Libreria / SDK:**
- NON esporre nuove funzioni pubbliche oltre quella richiesta.
- NON cambiare le firme di funzioni già pubbliche (breaking change).
- NON aggiungere dipendenze esterne — solo stdlib.

**CLI tool:**
- NON aggiungere nuovi sottocomandi oltre `foo`.
- NON supportare configurazione via file — solo flag CLI in questa iterazione.
- NON internazionalizzare i messaggi (solo inglese/italiano).

**Servizio web / backend:**
- NON supportare autenticazione OAuth — solo la già esistente.
- NON modificare lo schema del DB oltre la nuova tabella.
- NON ottimizzare query preesistenti anche se lente.

**Pipeline ML / data engineering:**
- NON cambiare il modello — solo il preprocessing.
- NON versionare i dataset (compito di altra pipeline).
- NON aggiungere step di validazione fuori da quello richiesto.

**App desktop / frontend:**
- NON toccare il tema/design system esistente.
- NON aggiungere shortcut da tastiera oltre quelli richiesti.
- NON refattorare componenti esistenti anche se toccati di passaggio.
