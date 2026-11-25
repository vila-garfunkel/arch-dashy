import Quickshell
import QtQuick

QtObject {
    property var applicationManager
    property string query: ""

    function matches(entry) {
        if (!entry) return false;
        if (query.trim().length === 0) return true;
        const q = query.toLowerCase();
        return String(entry.name || "").toLowerCase().includes(q)
            || String(entry.genericName || "").toLowerCase().includes(q)
            || String(entry.comment || "").toLowerCase().includes(q)
            || String(entry.id || "").toLowerCase().includes(q);
    }
}
