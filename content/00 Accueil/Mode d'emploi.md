# 📖 Mode d'emploi

## Comment c'est organisé
| Dossier | Contenu |
|---|---|
| `00 Accueil` | Tableau de bord ([[🏠 Accueil]]) et ce guide |
| `01 Inbox` | Notes rapides à trier plus tard |
| `10 Formation` | S1 → S6, une sous-dossier par SAÉ : note principale + 5 étapes + SWOT |
| `20 Stage` | Fiche de stage + actions datées |
| `30 Projets perso` | Projets hors formation, clients, freelance |
| `40 Référentiel MMI` | 5 compétences, CE, AC : **les hubs** qui affichent automatiquement tes preuves |
| `50 Réflexivité` | SWOT par compétence, préparation de la vidéo, soutenances |
| `80 Ressources` | Référentiel complet, cours, tutos |
| `99 Système` | Templates (ne pas y écrire de notes) |

## Le principe en une phrase
Tu écris dans tes **étapes / projets / actions de stage** quels AC et CE tu as travaillés (dans les **propriétés** en haut de la note) → chaque note AC / CE / compétence **liste toute seule** ses preuves grâce au plugin **Dataview**.

## Créer quelque chose
Raccourci **⌘ + ⌥ + N** (= *Templater : Create new note from template*), puis choisir :
- **Nouvelle SAÉ** → demande code, titre, semestre → crée le dossier, la note SAÉ, les 5 étapes et le SWOT
- **Action de stage** → note datée rangée dans `20 Stage`
- **Projet perso** → note rangée dans `30 Projets perso`
- **Étape SAÉ** / **SWOT** → si tu en as besoin d'une en plus

## Remplir une propriété de lien (AC, CE, compétence)
Dans le panneau des propriétés, clique sur la valeur de `ac`, tape `[[AC24` → Obsidian propose les AC → Entrée. Une valeur par ligne.
- `maitrise` : `acquis`, `en cours` ou `non acquis`
- `auto_eval` : note de **1 à 10**
- `note` (SAÉ) : la note obtenue, séparée de ton auto-évaluation

## Routine conseillée
1. **Pendant une SAÉ** : remplis l'étape en cours (10 min max à chaque fin de séance).
2. **En fin de SAÉ** : SWOT + auto-éval + liens vers livrables.
3. **Chaque mois** : ouvre [[🏠 Accueil]] → section « AC sans preuve » → choisis quoi travailler.
4. **Avant la vidéo** : [[Préparation vidéo BUT2]] regroupe toutes tes preuves par AC.

## Fonctions du tableau de bord
- **Niveaux & XP** : chaque étape rapporte de l'XP aux compétences de ses AC (acquis 40, en cours 20, sinon 10 ; projet 25), plus 50 par AC prouvé. Le niveau L s'atteint à 100 × L × (L − 1) XP.
- **Badges** : 13 succès qui se débloquent tout seuls (survole-les pour voir la condition).
- **Radar** : % d'AC prouvés par compétence, niveau 1 en pointillés gris, niveau 2 en cyan.
- **Heatmap** : ton activité sur 6 mois (une propriété `date` compte double, une modification de note compte simple).
- **Frise S1 → S6** : le semestre en cours pulse.
- **[[Carte du parcours]]** : un bouton génère un Canvas compétences → SAÉ/projets → AC.
- **[[Préparation vidéo BUT2]]** : plan minuté construit à partir de tes meilleures preuves (renseigne `competences_choisies`).
- **[[Journal de bord]]** : bilans hebdo + série 🔥.

## Sur iPhone (capture rapide)
1. Le vault doit être accessible depuis le téléphone : le déplacer dans **iCloud Drive → Obsidian**, ou utiliser **Obsidian Sync** (payant), ou le plugin **Remotely Save**.
2. App Obsidian iOS : Réglages → Barre d'outils mobile → ajoute **Templater : Create new note from template**.
3. En fin de cours : bouton → **Preuve rapide**. La note arrive dans `01 Inbox`, tu la ranges ensuite sur Mac.

## Plugins installés
- **Dataview** : les blocs `dataviewjs` appellent tous **un seul script**, `99 Système/scripts/portfolio.js`. Chaque bloc choisit un `mode` (preuves, etapes, competence, stats…). Pour changer un tableau partout, on modifie ce fichier, pas les 100 notes.
- Le moteur lit les propriétés `ac`, `ce`, `competences`, `sae` : c'est pour ça qu'il faut les remplir avec des liens `[[…]]`.
- **Templater** : les modèles de `99 Système/Templates` (le code entre `<%* … %>` sert à automatiser).

## Thème
Le snippet `.obsidian/snippets/yann-portfolio.css` reprend le design de ton portfolio (fond #0A0B10, cyan #00F0FF, Space Grotesk + Inter). Réglages → Apparence → Extraits CSS pour l'activer ou le désactiver. Les polices se chargent depuis Google Fonts (connexion internet nécessaire la première fois).

## Images et preuves
Glisse une capture dans une note : Obsidian la copie dans le vault et insère `![[image.png]]`. Pour le reste, privilégie les liens (GitHub, Figma, site en ligne).
