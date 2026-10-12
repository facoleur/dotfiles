---
title: Claude Code — Préférences globales
---

# Outils

- Recherche dans les fichiers : `rg` (pas `grep`)
- Recherche de fichiers : `fd` (pas `find`)
- Espace disque : `dust` (pas `du`)
- GitHub : `gh` CLI

Si un outil n'est pas disponible, fallback silencieux vers l'équivalent standard.

# Docker / orchestration

C'est **moi** qui gère mes conteneurs. N'exécute jamais de commande Docker qui
modifie l'état, ni les cibles Makefile qui l'enveloppent :

- Interdit : `docker compose up/down/restart/build/rm`, `docker run/stop/rm/network/volume …`,
  `make dev`, `make up`, `make down`, `make dev-down`, `make live`, `make migrate`, etc.
- Si une de ces actions est nécessaire, demande-moi de la lancer (je peux la taper avec `!`).
- Autorisé sans demander : lecture seule — `docker ps`, `docker logs`, `docker inspect`,
  `docker compose ps/config`, `make logs`, etc.

# Git — attribution

Les commits sont à mon nom seul. **N'ajoute jamais de ligne d'attribution à
Claude** dans un message de commit, un corps de PR ou une description :

- Interdit : `Co-Authored-By: Claude …`, `🤖 Generated with Claude Code`,
  « Co-authored-by » sous toutes ses formes, et tout lien de promotion.
- Vaut aussi pour les scripts que tu écris et qui committent à ma place.
