#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$HOME/.config/quickshell/desktop" "$HOME/.config/hypr"

# Preserve existing user files; copy only files that do not already exist.
cp -rn "$ROOT/quickshell/desktop/." "$HOME/.config/quickshell/desktop/"
install -Dm644 "$ROOT/hypr/desktop-bindings.conf" "$HOME/.config/hypr/desktop-bindings.conf"

printf '%s\n' \
  "Installed starter files." \
  "1. Set mainMonitorName in ~/.config/quickshell/desktop/services/MonitorManager.qml" \
  "2. Add these lines to your existing Hyprland config:" \
  "   source = ~/.config/hypr/desktop-bindings.conf" \
  "   exec-once = quickshell -c desktop" \
  "3. Test with: quickshell -c desktop"
