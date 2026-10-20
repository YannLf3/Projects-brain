#!/bin/bash

# Chemins
VAULT_DIR="/Users/yannleflohic/Documents/Obsidian Vault/2ndBrain/Second Cerveau"
QUARTZ_DIR="/Users/yannleflohic/Documents/quartz"

echo " Syncing Obsidian vault to Quartz..."

# Nettoyage et copie avec exclusion des dossiers privés/système
rsync -av --delete \
  --exclude='.obsidian/' \
  --exclude='.git/' \
  --exclude='01 Inbox/' \
  --exclude='20 Stage/' \
  --exclude='99 Système/' \
  "$VAULT_DIR/" "$QUARTZ_DIR/content/"

echo " Sync complete!"

# Build et déploiement via Quartz
cd "$QUARTZ_DIR" || exit
npx quartz sync
