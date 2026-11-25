import QtQuick

QtObject {
    id: root
    property bool active: false
    property var monitorPages: ({})
    property string mainSearchText: ""

    function pageFor(monitorName) {
        return monitorPages[monitorName] || "workspaces";
    }

    function setPage(monitorName, page) {
        if (!monitorName) return;
        let next = Object.assign({}, monitorPages);
        next[monitorName] = page;
        monitorPages = next;
    }

    function open() {
        active = true;
        monitorPages = ({});
        mainSearchText = "";
    }

    function close() {
        active = false;
        monitorPages = ({});
        mainSearchText = "";
    }

    function toggle() {
        if (active) close(); else open();
    }

    function showApplications(monitorName) {
        setPage(monitorName, "applications");
    }

    function showWorkspaces(monitorName) {
        setPage(monitorName, "workspaces");
    }

    function showSearch(text) {
        mainSearchText = text;
    }
}
