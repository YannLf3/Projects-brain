# 📓 Journal de bord
Un bilan par semaine (3 questions, 5 minutes) : ⌘ + ⌥ + N → **Bilan hebdo**. La série de semaines consécutives s'affiche sur l'[[🏠 Accueil]].

<!-- quartz:ignore -->
```dataview
TABLE WITHOUT ID file.link AS "Semaine", date AS "Date", energie AS "Énergie /5"
FROM "50 Réflexivité/Journal"
WHERE type = "bilan"
SORT date DESC
```
