import Quickshell.Hyprland
import QtQuick

QtObject {
    function dispatch(command) {
        Hyprland.dispatch(command);
        Hyprland.refreshToplevels();
        Hyprland.refreshWorkspaces();
    }

    function focus(address) {
        if (!address) return;
        dispatch("focuswindow address:" + address);
    }

    function close(address) {
        if (!address) return;
        dispatch("closewindow address:" + address);
    }

    function toggleFloating(address) {
        if (!address) return;
        dispatch("togglefloating address:" + address);
    }

    function fullscreen(address) {
        if (!address) return;
        dispatch("fullscreen 0 address:" + address);
    }

    // Initial tile-editing primitive: focus the selected client, then swap it
    // with a neighboring tiled client. This changes the real Hyprland layout.
    function swap(address, direction) {
        if (!address) return;
        Hyprland.dispatch("focuswindow address:" + address);
        Hyprland.dispatch("swapwindow " + direction);
        Hyprland.refreshToplevels();
    }

    function moveToWorkspace(address, workspaceName) {
        if (!address || !workspaceName) return;
        dispatch("movetoworkspace " + workspaceName + ",address:" + address);
    }
}
