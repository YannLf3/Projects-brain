#!/bin/bash

VAULT_DIR="/Users/yannleflohic/Documents/Obsidian Vault/2ndBrain/Second Cerveau"
QUARTZ_DIR="/Users/yannleflohic/Documents/quartz"

echo " Syncing Obsidian vault to Quartz..."

# Copie depuis Obsidian vers content/
rsync -av --delete \
  --exclude='.obsidian/' \
  --exclude='.git/' \
  --exclude='01 Inbox/' \
  --exclude='20 Stage/' \
  --exclude='99 Système/' \
  "$VAULT_DIR/" "$QUARTZ_DIR/content/"

# S'assure qu'un index.md existe toujours
if [ ! -f "$QUARTZ_DIR/content/index.md" ]; then
  echo "---" > "$QUARTZ_DIR/content/index.md"
  echo "title: Accueil" >> "$QUARTZ_DIR/content/index.md"
  echo "---" >> "$QUARTZ_DIR/content/index.md"
  echo "" >> "$QUARTZ_DIR/content/index.md"
  echo "# Bienvenue dans mon Second Brain 🧠" >> "$QUARTZ_DIR/content/index.md"
fi

echo " Sync complete!"

# Envoi vers GitHub
cd "$QUARTZ_DIR" || exit
git add .
git commit -m "Update notes $(date +'%Y-%m-%d %H:%M')"
git push origin main
