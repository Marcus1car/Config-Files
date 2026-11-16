#!/usr/bin/env bash
# Copy live config files into this repo, then commit and push whatever changed.
# Run monthly by systemd/config-sync.timer; safe to run by hand too.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO"

# live file | path in repo
MAP=(
  "$HOME/.config/alacritty/alacritty.toml|alacritty/alacritty.toml"
  "$HOME/.config/kitty/kitty.conf|kitty/kitty.conf"
  "$HOME/.config/helix/config.toml|helix/config.toml"
  "$HOME/.config/helix/languages.toml|helix/languages.toml"
  "$HOME/.config/helix/themes/my_theme.toml|helix/themes/my_theme.toml"
  "$HOME/.tmux.conf|tmux/.tmux.conf"
  "$HOME/.zshrc|zsh/.zshrc-spaceship"
  "$HOME/.config/herdr/config.toml|herdr/config.toml"
)

paths=()
for entry in "${MAP[@]}"; do
  src="${entry%%|*}" dest="${entry#*|}"
  # A missing source never deletes the repo copy
  [[ -f "$src" ]] || { echo "skip (missing): $src"; continue; }
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  paths+=("$dest")
done

# Only touch the mapped paths, so unrelated work in the repo is left alone
git add -- "${paths[@]}"
if git diff --cached --quiet -- "${paths[@]}"; then
  echo "nothing changed"
  exit 0
fi

changed="$(git diff --cached --name-only -- "${paths[@]}")"
git commit -m "config sync $(date +%F)" -m "$changed" -- "${paths[@]}"

# Network may not be up yet when a missed run fires right after login
for attempt in 1 2 3; do
  git push origin HEAD && exit 0
  echo "push failed (attempt $attempt), retrying in 60s"
  sleep 60
done
echo "push failed; commit is local, it will go out with the next push" >&2
exit 1
