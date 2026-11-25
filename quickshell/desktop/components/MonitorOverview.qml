import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import "overview"
import "dash"

Item {
    id: root
    required property var screen
    required property bool isMain
    required property var overviewManager
    required property var dashManager
    required property var windowManager
    required property var workspaceManager
    required property var applicationManager
    required property var searchManager

    Rectangle { anchors.fill: parent; color: "#d91b1c20" }

    Column {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 18

        // Search is rendered only on the main monitor, but does not block
        // clicking or launching items on any secondary monitor.
        SearchView {
            visible: root.isMain && root.overviewManager.pageFor(root.screen.name) === "search"
            width: Math.min(parent.width * 0.42, 460)
            searchManager: root.searchManager
            overviewManager: root.overviewManager
            monitorName: root.screen.name
        }

        Row {
            visible: root.isMain && root.overviewManager.pageFor(root.screen.name) === "workspaces"
            spacing: 8
            Repeater {
                model: Hyprland.workspaces
                delegate: Rectangle {
                    required property var modelData
                    visible: modelData.monitor && modelData.monitor.name === root.screen.name
                    width: 92; height: 54; radius: 8
                    color: modelData.active ? "#62656b" : "#393b40"
                    Text { anchors.centerIn: parent; color: "white"; text: "Workspace " + modelData.name; font.pixelSize: 10 }
                    MouseArea { anchors.fill: parent; onClicked: root.workspaceManager.activate(modelData) }
                }
            }
        }

        Item { width: 1; height: 1 }

        WorkspaceOverview {
            visible: root.overviewManager.pageFor(root.screen.name) === "workspaces"
            width: parent.width
            height: parent.height * 0.68
            screen: root.screen
            windowManager: root.windowManager
            workspaceManager: root.workspaceManager
        }

        ApplicationGrid {
            visible: root.overviewManager.pageFor(root.screen.name) === "applications" || (root.isMain && root.overviewManager.pageFor(root.screen.name) === "search")
            width: parent.width
            height: parent.height * 0.70
            applicationManager: root.applicationManager
            searchManager: root.searchManager
            windowManager: root.windowManager
            screen: root.screen
            isSearch: root.isMain && root.overviewManager.pageFor(root.screen.name) === "search"
        }
    }

    Dash {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 14
        screen: root.screen
        dashManager: root.dashManager
        overviewManager: root.overviewManager
        applicationManager: root.applicationManager
        onShowApplications: root.overviewManager.showApplications(root.screen.name)
    }

    focus: true
    Component.onCompleted: if (root.isMain) forceActiveFocus()

    Keys.onEscapePressed: root.overviewManager.close()
    Keys.onPressed: function(event) {
        if (root.isMain && event.text && event.text.length === 1 && !event.modifiers) {
            root.overviewManager.mainSearchText += event.text;
            root.searchManager.query = root.overviewManager.mainSearchText;
            root.overviewManager.setPage(root.screen.name, "search");
            event.accepted = true;
        }
    }
}
