---
name: test
description: Scrivere ed eseguire test per una funzionalità appena implementata. Usare quando l'utente dice "testa", "scrivi i test", "verifica la copertura" dopo un'implementazione. Sesta fase del workflow feature-driven.
---

# Testing e verifica

Fase 6/8 del workflow. Verifica che l'implementazione soddisfi la spec.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. Rileggere i **criteri di accettazione** in `.claude/spec.md` del progetto.
3. Per ogni criterio scrivere almeno un test, scegliendo il livello adatto al tipo di software:
   - **Unit test** per la logica pura (una funzione, un metodo, una trasformazione).
   - **Integration test** per l'interazione tra unità reali (moduli, subprocess, I/O, servizi esterni "veri"). Mockare solo dipendenze genuinamente non controllabili in test (rete esterna a pagamento, hardware, tempo).
   - **End-to-end / behavior test** per il flusso completo dal punto di vista del consumatore (utente CLI, chiamante di libreria, client di servizio, esecutore di script).
   - **Edge case**: input vuoti, valori limite, errori attesi, encoding, timezone, precisione numerica se rilevante.
4. Eseguire l'intera suite (non solo i nuovi test) per catturare regressioni.
5. Se ci sono fallimenti: capire causa radice, non silenziare.
6. Produrre `.claude/test-report.md` opzionale con esito, o riportare direttamente in chat.
7. Con suite verde, suggerire `/skill:refactor` per pulire prima del commit, oppure `/skill:commit` per andare diretti al consolidamento.

## Output atteso

Test aggiunti, suite verde, coverage sui criteri di accettazione dichiarati.

## Regole

- **[GUARDRAIL SCOPE]** Aggiungi test **solo** per la funzionalità corrente. Non riscrivere o "migliorare" test esistenti fuori dallo scope. Vedi `/skill:guardrail-scope`.
- Non testare l'implementazione (i dettagli), testa il comportamento (la spec).
- Un test che passa senza fare nulla di significativo è peggio di un test mancante — verificarne il valore.
- Se un test è flaky, marcarlo esplicitamente e aprire un task, non riprovare in loop.
