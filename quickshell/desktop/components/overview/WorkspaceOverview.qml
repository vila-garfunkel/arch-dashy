import QtQuick
import Quickshell.Hyprland
import "../windows"

Item {
    id: root
    required property var screen
    required property var windowManager
    required property var workspaceManager

    Grid {
        anchors.centerIn: parent
        width: Math.min(parent.width, 1100)
        height: parent.height
        columns: 2
        spacing: 24

        Repeater {
            model: Hyprland.workspaces
            delegate: Rectangle {
                required property var modelData
                property var ws: modelData
                visible: ws.monitor && ws.monitor.name === root.screen.name && ws.toplevels.count > 0
                width: Math.min((root.width - 30) / 2, 520)
                height: Math.min(root.height - 20, 340)
                radius: 16
                color: "#252a36"
                border.color: ws.active ? "#9bbcff" : "#565b66"
                border.width: ws.active ? 2 : 1
                clip: true

                Text { x: 16; y: 12; text: "Workspace " + ws.name; color: "#f1f2f4"; font.pixelSize: 13; font.bold: true }
                Text { anchors.right: parent.right; anchors.rightMargin: 16; anchors.top: parent.top; anchors.topMargin: 12; text: ws.toplevels.count + " windows"; color: "#aeb4c0"; font.pixelSize: 11 }

                // Tiled and floating workspaces deliberately share the same
                // workspace card. Floating previews use geometry metadata;
                // tiled previews are laid out as spaced, editable tiles.
                Flow {
                    anchors.fill: parent
                    anchors.margins: 42
                    spacing: 14
                    Repeater {
                        model: ws.toplevels
                        delegate: WindowPreview {
                            required property var modelData
                            window: modelData
                            tiled: !Boolean(modelData.lastIpcObject && modelData.lastIpcObject.floating)
                            windowManager: root.windowManager
                        }
                    }
                }
                MouseArea { anchors.fill: parent; z: -1; onClicked: root.workspaceManager.activate(ws) }
            }
        }
    }
}
