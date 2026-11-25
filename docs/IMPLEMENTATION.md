# Implementation notes and known gaps

## Overview and per-monitor behavior

The shell creates one full-screen `PanelWindow` overview surface per connected Quickshell screen. The same global shortcut toggles the shared overview state, so every monitor enters/exits overview together. Each surface receives its own `screen` and therefore its own Dash/application-grid launch context. Only the configured main monitor receives the top panel and search field.

## Search

The initial search implementation filters Quickshell `DesktopEntries.applications` by name, generic name, comment, and desktop-entry ID. File search is deliberately left as an adapter point. A practical Linux file-search backend can be added later (e.g. `fd`/`plocate`/Tracker) with a dedicated service.

## Window previews

The initial preview component uses Hyprland toplevel metadata (title, address, workspace) and does not yet capture actual window pixels. Quickshell has screencopy facilities, but correct per-window capture, scaling, permissions, and lifecycle handling should be implemented and tested separately.

## Tiled editing

Close and focus operations are wired to Hyprland dispatchers. The four arrow buttons focus the selected client and issue a directional `swapwindow` operation. This is a safe first implementation of tile reordering, but it is not free-form drag-and-drop. Arbitrary drag-to-position requires choosing a Hyprland layout strategy (Dwindle/Master/custom) and mapping pointer geometry to layout-specific operations.

## Workspace lifecycle

Hyprland normally destroys unused ordinary workspaces. The starter's `removeIfEmpty()` deliberately avoids destructive cleanup commands and refreshes the model instead. Custom mode metadata is currently in-memory; persistence and deterministic workspace numbering should be added after monitor/workspace behavior is validated.

## Launch target monitor

`DesktopEntry.execute()` is used because it correctly handles desktop entry launch semantics better than parsing `Exec` strings ourselves. However, an already-running application may reuse an existing window, and desktop-entry launching does not guarantee that a new window appears on the Dash's monitor. A robust solution requires a launch broker that tracks the clicked monitor and correlates the resulting Hyprland `openwindow` event, then moves that specific new window. That is the next integration task.

## Super shortcut

Quickshell registers a Hyprland global shortcut using `GlobalShortcut`. The companion Hyprland binding is in `hypr/desktop-bindings.conf`. This is a Hyprland-specific protocol and requires the compositor to support `hyprland_global_shortcuts_v1`.

## Window controls

Close and floating-state toggle are implemented. Minimize is intentionally left unimplemented because Wayland does not provide one universal minimize request for arbitrary clients. We can implement a desktop-level minimize convention using a special workspace, but that behavior should be agreed before wiring it.
