---
type: ressource
tags: [quartz, publication]
---
# 🌐 Publier le Second Cerveau avec Quartz

> **Quartz** est un générateur de site statique (SSG) qui transforme un dossier Markdown Obsidian en site web : liens `[[…]]`, rétroliens, graphe, recherche, aperçus au survol. On le déploie gratuitement sur **GitHub Pages**, sur un sous-domaine de `yannleflohic.fr`.

## 0. Ce qu'il faut savoir avant de commencer
| Point | Conséquence |
|---|---|
| Quartz **n'exécute pas Dataview** | Chaque bloc `dataview`/`dataviewjs` du vault est précédé de `<!-- quartz:ignore -->`. Ce commentaire est invisible dans Obsidian et **ne fait rien tout seul** : c'est `publish.sh` (étape 6) qui supprime le marqueur et le bloc qui le suit. Pour les « cuire » en Markdown plutôt que les supprimer, voir l'étape 9. |
| Quartz ne compte pas les liens écrits dans les **propriétés** | Les rétroliens d'une page AC seront vides tant que les blocs ne sont pas cuits. |
| Le site est **public** | Exclure Stage, Inbox, Système ; anonymiser les noms de tiers (binômes, personnes interviewées pour le PAL). |
| Les fichiers `.canvas` | Ne sont pas publiés : exporte la carte en image si tu veux la montrer. |

## 1. Prérequis
```bash
node -v   # v22 ou plus
npm -v    # 10.9 ou plus
git --version
```
Sur Mac : `brew install node` si besoin.

## 2. Créer le projet Quartz (une seule fois)
On garde le site **séparé du vault** : le vault reste ta source, le dépôt Quartz reçoit une copie filtrée.
```bash
cd ~/Developer          # ou le dossier où tu ranges tes projets
git clone https://github.com/jackyzha0/quartz.git second-cerveau-site
cd second-cerveau-site
npm i
npx quartz create
```
Réponses à l'assistant :
1. **Choose how to initialize the content** → `Empty Quartz` (on remplira `content/` avec le script de l'étape 6).
2. **Choose how Quartz should resolve links** → `Treat links as shortest path` (c'est le comportement d'Obsidian).

## 3. Configurer `quartz.config.ts`
Ouvre le fichier dans VS Code et adapte le bloc `configuration` :
```ts
configuration: {
  pageTitle: "Second Cerveau · Yann Le Flohic",
  pageTitleSuffix: "",
  enableSPA: true,            // navigation sans rechargement
  enablePopovers: true,       // aperçu des notes au survol des liens
  analytics: null,
  locale: "fr-FR",
  baseUrl: "cerveau.yannleflohic.fr",
  ignorePatterns: ["private", "templates", ".obsidian", "**/*.canvas"],
  defaultDateType: "modified",
  theme: {
    fontOrigin: "googleFonts",
    cdnCaching: true,
    typography: { header: "Space Grotesk", body: "Inter", code: "JetBrains Mono" },
    colors: {
      // Même palette dans les deux modes → site toujours sombre, comme ton portfolio
      lightMode: {
        light: "#0A0B10", lightgray: "#13151F", gray: "#8B8D98", darkgray: "#E2E2E9",
        dark: "#FFFFFF", secondary: "#00F0FF", tertiary: "#7DF9FF",
        highlight: "rgba(0, 240, 255, 0.08)", textHighlight: "rgba(0, 240, 255, 0.25)",
      },
      darkMode: {
        light: "#0A0B10", lightgray: "#13151F", gray: "#8B8D98", darkgray: "#E2E2E9",
        dark: "#FFFFFF", secondary: "#00F0FF", tertiary: "#7DF9FF",
        highlight: "rgba(0, 240, 255, 0.08)", textHighlight: "rgba(0, 240, 255, 0.25)",
      },
    },
  },
},
```
Rôle des couleurs Quartz : `light` = fond, `lightgray` = bordures et surfaces, `gray` = texte secondaire, `darkgray` = texte, `dark` = titres, `secondary` = liens, `tertiary` = survol.

Dans le bloc `plugins.filters`, garde `Plugin.RemoveDrafts()` : toute note avec `draft: true` dans ses propriétés ne sera pas publiée. C'est ton interrupteur note par note.

## 4. Page d'accueil du site
Quartz affiche `content/index.md` comme page d'accueil. Ton Accueil Obsidian est fait en JS, donc on crée un accueil dédié **à la racine du projet** (hors `content/`, le script le copiera) : `site-index.md`
```markdown
---
title: Second Cerveau
---
Portfolio de compétences de **Yann Le Flohic**, étudiant en BUT MMI parcours Développement web et dispositifs interactifs.

- 🧭 Les 5 compétences : [[Comprendre]] · [[Concevoir]] · [[Exprimer]] · [[Développer]] · [[Entreprendre]]
- 🎓 Mes SAÉ, semestre par semestre, avec leur fiche de bord en 5 étapes
- 🧪 Mes projets hors formation
- 🌐 [Mon portfolio](https://yannleflohic.fr) · [GitHub](https://github.com/YannLf3)
```

## 5. Style : reprendre ton thème
Dans `quartz/styles/custom.scss` (déjà présent), ajoute :
```scss
@use "./base.scss";

// Filet de sécurité : masque un bloc Dataview qui aurait échappé au marqueur <!-- quartz:ignore -->
figure[data-rehype-pretty-code-figure]:has(pre[data-language="dataviewjs"]),
figure[data-rehype-pretty-code-figure]:has(pre[data-language="dataview"]) {
  display: none;
}

// Badges et cartes, mêmes noms de classes que dans Obsidian
.yl-badge { display: inline-block; padding: 0.1rem 0.6rem; font-size: 0.72rem; border: 1px solid currentColor; border-radius: 999px; }
h1, h2, h3 { letter-spacing: -0.02em; }
h2::after { content: ""; display: block; width: 2.5rem; height: 2px; margin-top: 0.35rem; background: var(--secondary); box-shadow: 0 0 0.9rem rgba(0, 240, 255, 0.35); }
```
Tu peux recopier d'autres règles de `.obsidian/snippets/yann-portfolio.css` : les variables `--yl-*` fonctionnent pareil.

## 6. Script de publication : vault → `content/`
À la racine du projet Quartz, crée `publish.sh` :
```bash
#!/usr/bin/env bash
set -euo pipefail
VAULT="$HOME/Documents/Obsidian Vault/2ndBrain/Second Cerveau"

# 1. Copie filtrée du vault (le privé ne quitte jamais ton Mac)
rsync -a --delete \
  --exclude ".obsidian" --exclude ".trash" \
  --exclude "00 Accueil" --exclude "01 Inbox" \
  --exclude "20 Stage" --exclude "99 Système" \
  --exclude "*.canvas" \
  "$VAULT/" content/

# 2. Page d'accueil du site
cp site-index.md content/index.md

# 2bis. Retire les blocs Dataview marqués <!-- quartz:ignore --> (marqueur + bloc qui suit)
find content -name '*.md' -exec perl -0pi -e 's/<!-- quartz:ignore -->\s*```dataview.*?```\s*//gs' {} +

# 3. (Étape 9) cuisson des blocs Dataview
[ -f scripts/bake.mjs ] && node scripts/bake.mjs content

# 4. Vérification locale puis envoi
npx quartz build
npx quartz sync
```
Puis : `chmod +x publish.sh`.

Aperçu local à tout moment : `npx quartz build --serve` → <http://localhost:8080>.

## 7. Dépôt GitHub + déploiement automatique
1. Sur GitHub, crée un dépôt **vide** `second-cerveau-site` (sans README).
2. Dans le dossier du projet :
```bash
git remote set-url origin https://github.com/YannLf3/second-cerveau-site.git
git remote add upstream https://github.com/jackyzha0/quartz.git   # pour récupérer les mises à jour de Quartz
npx quartz sync --no-pull    # premier envoi
```
3. Crée `.github/workflows/deploy.yml` :
```yaml
name: Deploy Quartz site to GitHub Pages
on:
  push:
    branches: [v4]
permissions:
  contents: read
  pages: write
  id-token: write
concurrency:
  group: "pages"
  cancel-in-progress: false
jobs:
  build:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0          # nécessaire pour les dates de modification
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - run: npm ci
      - run: npx quartz build
      - uses: actions/upload-pages-artifact@v3
        with:
          path: public
  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```
4. GitHub → dépôt → **Settings → Pages → Source : GitHub Actions**.
5. `npx quartz sync` → l'onglet **Actions** montre le build ; au bout d'1 à 2 min le site est en ligne sur `yannlf3.github.io/second-cerveau-site`.

> La branche par défaut de Quartz s'appelle `v4` : c'est pour ça que le workflow écoute `v4` et pas `main`.

## 8. Sous-domaine `cerveau.yannleflohic.fr`
1. Chez ton registrar (là où est géré `yannleflohic.fr`) → zone DNS → ajoute :
   `cerveau   CNAME   yannlf3.github.io.`
2. GitHub → Settings → Pages → **Custom domain** : `cerveau.yannleflohic.fr` → Save.
3. Attends la vérification DNS (quelques minutes à quelques heures), puis coche **Enforce HTTPS**.
4. Vérifie que `baseUrl` dans `quartz.config.ts` vaut bien `cerveau.yannleflohic.fr`.

## 9. Solution propre : « cuire » les tableaux Dataview
Idée : avant le build, un script Node lit `content/`, et remplace chaque bloc
` ```dataviewjs await dv.view(…, { mode: "preuves" }) ``` `
par le **tableau Markdown calculé** (mêmes règles que `portfolio.js` : lecture des propriétés `ac`, `ce`, `sae`, `competences`). Avantages : les pages AC listent leurs preuves en ligne, les liens deviennent de vrais liens → rétroliens et graphe Quartz complets.
- Fichier : `scripts/bake.mjs` (déjà appelé par `publish.sh` s'il existe).
- Dépendances : `npm i -D gray-matter` (lecture du frontmatter).
- Modes à cuire en priorité : `preuves`, `etapes`, `competence`, `chronologie`, `projets`.
→ Demande-le-moi dans une nouvelle conversation : « écris scripts/bake.mjs pour Quartz à partir de 99 Système/scripts/portfolio.js ».

## 10. Routine de mise à jour
```bash
cd ~/Developer/second-cerveau-site
./publish.sh
```
Pour récupérer une nouvelle version de Quartz : `git pull upstream v4`, puis `npm i`.

## ✅ Checklist avant la première mise en ligne
- [ ] Noms de tiers anonymisés (binômes, personnes interviewées) ou accord obtenu
- [ ] Aucune note sensible hors des dossiers exclus (sinon `draft: true`)
- [ ] Aperçu local vérifié (`npx quartz build --serve`)
- [ ] Liens externes testés
- [ ] HTTPS activé sur le domaine

> 🆕 **Nouvelle note avec un bloc Dataview ?** Mets `<!-- quartz:ignore -->` sur la ligne juste au-dessus du bloc (les modèles le font déjà).
