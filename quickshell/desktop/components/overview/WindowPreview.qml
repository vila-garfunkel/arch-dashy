import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    required property var window
    required property bool tiled
    required property var windowManager
    width: tiled ? 205 : 220
    height: tiled ? 118 : 132
    radius: 10
    color: "#e8e9ed"
    border.color: "#b9bdc7"
    border.width: 1

    Column {
        z: 1
        anchors.fill: parent
        anchors.margins: 10
        spacing: 6
        Row {
            width: parent.width
            spacing: 5
            Text { width: parent.width - 28; text: root.window.title || "Application"; elide: Text.ElideRight; color: "#202127"; font.pixelSize: 11; font.bold: true }
            ToolButton { width: 24; height: 22; text: "×"; onClicked: root.windowManager.close(root.window.address) }
        }
        Rectangle { width: parent.width; height: 1; color: "#c8cbd2" }
        Text { text: root.tiled ? "Tiled window" : "Floating window"; color: "#646873"; font.pixelSize: 10 }
        Item { width: 1; height: 1 }
        Row {
            visible: root.tiled
            spacing: 3
            Repeater {
                model: ["←", "↑", "↓", "→"]
                delegate: ToolButton {
                    required property string modelData
                    width: 34; height: 24
                    text: modelData
                    onClicked: {
                        const dirs = {"←":"l", "↑":"u", "↓":"d", "→":"r"};
                        root.windowManager.swap(root.window.address, dirs[modelData]);
                    }
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        z: 0
        onClicked: root.windowManager.focus(root.window.address)
    }
}
