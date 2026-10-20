---
type: "sae"
code: "SAÉ 2.03"
titre: "Concevoir un site web avec une source de données"
semestre: "S2"
annee: "2025-2026"
parcours: "Tronc commun"
date_debut: "2026-04-22"
date_fin: "2026-05-07"
statut: "terminée"
equipe: []
competences:
  - "[[Développer]]"
ac:
  - "[[AC14.01]]"
  - "[[AC14.02]]"
  - "[[AC14.03]]"
  - "[[AC14.04]]"
  - "[[AC14.05]]"
  - "[[AC14.06]]"
ce:
  - "[[CE4.01]]"
  - "[[CE4.02]]"
  - "[[CE4.03]]"
  - "[[CE4.04]]"
  - "[[CE4.05]]"
ressources:
  - "R2.12"
  - "R2.13"
  - "R2.14"
  - "R2.15"
livrables:
  - "https://leflohic-sae203.mmi-limoges.fr"
note:
auto_eval:
tags:
  - "sae"
  - "s2"
---
# SAÉ 2.03 — Concevoir un site web avec une source de données

## 📌 Sujet
**StreamFlix** : plateforme de streaming type Netflix (APP + back-office ADMIN), 95 h, 19 itérations. Problématique : « Comment consulter de manière fluide des contenus stockés en base et permettre aux utilisateurs d'interagir avec ? »

Stack : HTML5 sémantique, framework CSS maison (@layer), JS modulaire, PHP MVC, MySQL, API REST JSON, GitHub (dépôt SAE2.03-leflohic), serveur mmi.unilim.fr.

## 📦 Livrables
- Application en ligne (APP + ADMIN)
- Dépôt GitHub SAE2.03-leflohic + README
- Modèle relationnel Looping + export SQL
- Audit Lighthouse

## 🪜 Déroulement (fiche de bord en 5 étapes)
```dataviewjs
await dv.view("99 Système/scripts/portfolio", { mode: "etapes" })
```

## ⚠️ Difficultés rencontrées et résolutions
- URL relatives de fetch() invalides en production (404) → constante BASE_URL avec chemins absolus
- Où regrouper les films par catégorie (JS, PHP ou MySQL ?) → côté MySQL (ORDER BY), moins de traitement front et de bande passante
- Profil actif partagé entre composants → variable globale activeProfile mise à jour par le handler

## 📚 Ressources mobilisées
- R2.12 Intégration : framework CSS @layer, Atomic CSS, BEM, Lighthouse
- R2.13 Développement web : composants JS, ES6, MVC PHP, API REST
- R2.14 Système d'information : Looping, SQL, PDO, phpMyAdmin
- R2.15 Hébergement : SSH, Git/GitHub, déploiement, sécurisation PDO

## 🖼️ Preuves & traces
<!-- Liens vers livrables, captures (![[image.png]]), dépôts GitHub, Figma… -->
- https://leflohic-sae203.mmi-limoges.fr

## 🧩 Bilan AC / CE
- AC14.01 ✅ VS Code Remote SSH sur mmi.unilim.fr, workflow Git quotidien
- AC14.02 ✅ HTML5 sémantique, aria-label, interactions JS
- AC14.03 ✅ Pages générées depuis MySQL via JSON, MVC strict
- AC14.04 ✅ Déployé (1re mise en ligne 30 avril, finale 7 mai), audit Lighthouse
- AC14.05 ✅ Modèle relationnel Looping, tables SAE203_films / profiles / favorites
- AC14.06 ✅ Architecture MVC (cf. soutenance BUT1)

## 🔍 Auto-évaluation
J'ai compris ce qu'est une application full-stack : chaque couche a un rôle précis et la qualité finale dépend de la rigueur de chacune. Présentée en soutenance BUT1 (compétence Développer).

![[SAÉ 2.03 - SWOT]]
