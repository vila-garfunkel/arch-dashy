import Quickshell
import Quickshell.Hyprland
import QtQuick

QtObject {
    // Set this to the exact output name from `hyprctl monitors`.
    // Leave empty to use the first connected monitor as main.
    property string mainMonitorName: ""

    function isMainScreen(screen) {
        if (!screen) return false;
        if (mainMonitorName.length > 0) return screen.name === mainMonitorName;
        return Quickshell.screens.length > 0 && screen.name === Quickshell.screens[0].name;
    }

    function monitorNameForScreen(screen) {
        const monitor = Hyprland.monitorFor(screen);
        return monitor ? monitor.name : (screen ? screen.name : "");
    }

    function isMainMonitorName(name) {
        if (mainMonitorName.length > 0) return name === mainMonitorName;
        return Quickshell.screens.length > 0 && name === Quickshell.screens[0].name;
    }
}
