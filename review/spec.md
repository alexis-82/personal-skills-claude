# Risultati della Code Review

## Correttezza
- [ ] Logica soddisfa i criteri di accettazione
- [ ] Branch condizionali coperti
- [ ] Nessun off-by-one / condizione invertita / null non gestito

## Edge case
- [ ] Input vuoti / limite gestiti
- [ ] Encoding / timezone / precisione numerica (se rilevanti)
- [ ] Concorrenza / ordine di esecuzione (se rilevanti)

## Sicurezza
- [ ] Input non fidati validati
- [ ] Nessuna injection possibile (SQL/command/path)
- [ ] Nessun secret hardcoded
- [ ] Autenticazione/autorizzazione a posto

## Prestazioni
- [ ] Nessuna query N+1 evidente
- [ ] Nessun loop nested inutile su dati grandi
- [ ] Nessuna chiamata di rete ripetuta evitabile

## Leggibilità / manutenibilità
- [ ] Naming chiaro
- [ ] Funzioni di lunghezza ragionevole
- [ ] Duplicazione contenuta
- [ ] Commenti spiegano il "perché", non il "cosa"

## Formato finding
```
### [severità] file:linea — titolo breve
Scenario: <input concreto> → <comportamento sbagliato>
Suggerimento: <direzione della fix in una frase>
```
