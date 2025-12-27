#!/bin/bash

# Script: delete-top-dir.sh
# Description: Lists top-level directories in the current directory,
#              lets you fuzzy-select one using nfzf (from node-fzf),
#              confirms the selection, and then deletes it with rm -rf.
# Requirements: node-fzf installed globally (npm install -g node-fzf)
# Warning: This permanently deletes the directory and all its contents!

# Get list of top-level directories (excluding . and .., only real dirs)
dirs=$(find . -mindepth 1 -maxdepth 1 -not -name '.*' | sed 's|^\./||')

if [ -z "$dirs" ]; then
  echo "No top-level directories found in the current directory."
  exit 1
fi

# Pipe the list to nfzf for fuzzy selection
# nfzf outputs the selected item to stdout (or nothing if cancelled)
selected=$(echo "$dirs" | nfzf)

if [ -z "$selected" ]; then
  echo "No directory selected. Aborting."
  exit 0
fi

# Confirm before deletion
echo "You selected: $selected"
read -p "Are you sure you want to permanently delete '$selected' and all its contents? (y/N): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
  rm -rf "./$selected"
  if [ $? -eq 0 ]; then
    echo "'$selected' has been deleted."
  else
    echo "Failed to delete '$selected'."
    exit 1
  fi
else
  echo "Deletion cancelled."
fi
