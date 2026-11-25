import Quickshell
import QtQuick

QtObject {
    function launch(entry, screenName) {
        if (!entry) return;
        // DesktopEntry.execute() is the safest standards-aware launch path.
        // Monitor placement is a best-effort integration point; applications
        // that restore existing windows may not create a new window to move.
        entry.execute();
    }

    function entries() {
        return DesktopEntries.applications;
    }
}
