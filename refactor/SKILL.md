---
name: refactor
description: Migliorare la qualità del codice appena implementato senza cambiarne il comportamento, prima di consolidare in commit. Usare quando l'utente dice "refactora", "pulisci il codice", "semplifica", "riduci la duplicazione", tipicamente dopo che i test sono verdi e prima di committare. Settima fase del workflow feature-driven, opzionale.
---

# Refactoring

Fase 7/8 del workflow. Migliora la struttura mantenendo il comportamento, prima del commit finale.

## Perché prima del commit

Con i test verdi (fase 06) hai la rete di sicurezza per pulire il codice. Fare refactor **prima** del commit ha due vantaggi:
- il commit rappresenta la versione già pulita del lavoro, non richiede un "commit di pulizia" a posteriori;
- se il refactor rompe qualcosa, i test lo catturano subito e puoi correggere senza aver ancora sporcato la storia git.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. **Verificare che la suite di test sia verde prima di iniziare** — senza rete di sicurezza il refactor è cieco.
3. Identificare target concreti: duplicazione (3+ ripetizioni), funzioni troppo lunghe (>50 righe), naming ambiguo, dipendenze inutili, dead code.
4. Applicare un refactor alla volta:
   - Modifica minima focalizzata.
   - Eseguire i test dopo ogni cambio.
   - Se rompe qualcosa: revertire e riprovare in modo più piccolo.
5. Non introdurre astrazioni "per il futuro" — solo se emergono da 3+ casi reali già presenti.
6. Al termine, passare a `/skill:commit` per consolidare.

## Output atteso

Codice più semplice/leggibile, comportamento invariato (suite ancora verde), pronto per il commit finale.

## Regole

- **[GUARDRAIL SCOPE]** Il refactor ha binari anche quando è il task principale: opera **solo** sui file/aree toccati dall'implementazione corrente. Non allargare lo scope a codice preesistente non correlato perché "già che ci sono". Vedi `/skill:guardrail-scope`.
- **[NON-GOALS]** I Non-Goals di `spec.md` valgono anche in refactor: se la spec dice "NON toccare il modulo X" o "NON ottimizzare le query esistenti", questo divieto si applica anche qui — anche se il modulo X sembra "urlare" per essere pulito.
- Non mescolare refactor e cambio di comportamento — se scopri di dover cambiare comportamento, torna a `/skill:implement`.
- Se un refactor rompe i test, capire se il test era sbagliato o se il refactor ha cambiato il comportamento — nel dubbio, revertire.
- No refactor speculativi: se il codice funziona ed è leggibile "abbastanza", lascialo stare e passa al commit.
- Aggiungere astrazioni solo quando ne emerge il bisogno, non prima.
- Prima di partire, dichiarare esplicitamente all'utente lo scope del refactor e attendere conferma.
- In fase di commit (`commit`), tenere i commit di refactor **separati** dai commit di feature per una storia git leggibile.
