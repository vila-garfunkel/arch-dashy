# Hyprland Workflow Desktop

A modular Quickshell starter for the custom Hyprland desktop discussed in the design conversation.

## Included

- Global Super shortcut opens/closes overview surfaces on every connected monitor.
- Main monitor is configurable; only it displays the search field and top panel.
- Every monitor gets its own overview surface, independent overview page state, and an overview-only floating Dash.
- Windowed and tiled overview cards are metadata-based previews; precise live geometry and screencopy thumbnails are reserved for the next iteration.
- Tiled overview presents interactive cards; close and focus are wired, and directional swap controls are provided as a safe first layout-editing mechanism.
- Application grid is available from each monitor's Dash.
- Desktop entries are loaded from Quickshell's `DesktopEntries` model.
- Search filters installed applications on the main monitor. File search is an integration point, not enabled by default.
- Services are separated from visual components.

## Important implementation boundaries

This is a **starter implementation**, not a fully polished production desktop. Quickshell/Hyprland APIs evolve, and the QML has not been executed on your machine. The overview currently uses window metadata cards, not live screencopy thumbnails. Tiled rearrangement uses Hyprland directional swaps rather than arbitrary drag-to-grid layout editing. A later iteration can add live previews and layout-aware drag/drop after testing against your exact Hyprland and Quickshell versions.

The design intentionally avoids guessing a monitor connector. Set `mainMonitorName` in `services/MonitorManager.qml` after checking `hyprctl monitors`.

## Requirements

- Hyprland
- Quickshell (recommended current stable, docs referenced: 0.3.2)
- QtQuick modules provided by your Quickshell package
- `hyprctl`
- `xdg-terminal-exec` or your preferred terminal (optional)

## Install

From this extracted folder:

```bash
mkdir -p ~/.config/quickshell/desktop
cp -a quickshell/desktop/. ~/.config/quickshell/desktop/
mkdir -p ~/.config/hypr
cp -n hypr/*.conf ~/.config/hypr/
```

Merge the contents of `hypr/hyprland.conf` into your existing `~/.config/hypr/hyprland.conf`; do not overwrite a working configuration blindly.

Set your main monitor name in:

```text
~/.config/quickshell/desktop/services/MonitorManager.qml
```

Then add to Hyprland config:

```ini
source = ~/.config/hypr/desktop-bindings.conf
exec-once = quickshell -c desktop
```

If your Quickshell build uses a different CLI syntax, check `quickshell --help`.

## Run manually

```bash
quickshell -c desktop
```

## Validate

```bash
qmllint ~/.config/quickshell/desktop/shell.qml
quickshell -c desktop
```

Check runtime logs in the terminal. If a component API differs in your package, the error should identify the exact QML file and line.

## Current controls

- `Super`: toggle overview on all monitors (Hyprland global shortcut).
- `Escape`: close overview when the overview surface has keyboard focus.
- Click a window card: focus that window.
- Close button on a window card: close that window.
- Tiled card directional buttons: swap the focused window with a neighboring tile.
- Dash app icon: launch application entry. Monitor-targeted launch is currently best-effort; see `docs/IMPLEMENTATION.md`.
- Search: filters installed application entries on the main monitor.

## Safety

Do not enable this alongside another shell's panel/overview bindings until you have tested it in a separate session. Keep a TTY or SSH route available while experimenting with compositor configuration.
