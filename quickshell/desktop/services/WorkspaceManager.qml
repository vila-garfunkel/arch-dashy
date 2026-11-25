import Quickshell.Hyprland
import QtQuick

QtObject {
    property var windowManager
    property var workspaceModes: ({})
    property int firstWorkspaceId: 1

    function keyFor(workspace) {
        if (!workspace) return "";
        return String(workspace.id);
    }

    function modeFor(workspace) {
        const key = keyFor(workspace);
        return workspaceModes[key] || "TILED";
    }

    function setMode(workspace, mode) {
        const key = keyFor(workspace);
        if (!key) return;
        let next = Object.assign({}, workspaceModes);
        next[key] = mode;
        workspaceModes = next;
    }

    function activate(workspace) {
        if (workspace) workspace.activate();
    }

    function createWindowedWorkspace() {
        // Number allocation is deliberately conservative. Hyprland remains
        // authoritative; this chooses the first currently unused positive ID.
        let used = {};
        for (let i = 0; i < Hyprland.workspaces.count; i++) {
            const ws = Hyprland.workspaces.get(i);
            if (ws && ws.id > 0) used[ws.id] = true;
        }
        let id = firstWorkspaceId;
        while (used[id]) id++;
        Hyprland.dispatch("workspace " + id);
        setMode({ id: id }, "WINDOWED");
        return id;
    }

    function removeIfEmpty(workspace) {
        // Hyprland normally destroys unused ordinary workspaces itself.
        // This method intentionally avoids destroying the active/last workspace.
        if (!workspace || workspace.active || workspace.toplevels.count > 0) return;
        Hyprland.refreshWorkspaces();
    }
}
