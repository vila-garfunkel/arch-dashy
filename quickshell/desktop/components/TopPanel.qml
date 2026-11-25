import QtQuick
import Quickshell
import Quickshell.Hyprland
import "windows"

Rectangle {
    id: root
    required property var overviewManager
    required property var monitorManager
    required property var windowManager
    color: "#202124"

    Row {
        anchors.fill: parent
        anchors.leftMargin: 14
        anchors.rightMargin: 12
        spacing: 12

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: activitiesLabel.implicitWidth + 22
            height: 27
            radius: 14
            color: "#3a3b3e"
            Text { id: activitiesLabel; anchors.centerIn: parent; text: "Activities"; color: "#f5f5f5"; font.pixelSize: 12; font.bold: true }
            MouseArea { anchors.fill: parent; onClicked: root.overviewManager.toggle() }
        }
        Item { width: 150; height: 1 }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatDateTime(new Date(), "ddd MMM d  HH:mm")
            color: "#eeeeee"
            font.pixelSize: 12
        }
        Item { width: 150; height: 1 }
        WindowControls {
            anchors.verticalCenter: parent.verticalCenter
            windowManager: root.windowManager
            address: Hyprland.activeToplevel ? Hyprland.activeToplevel.address : ""
        }
        Text { anchors.verticalCenter: parent.verticalCenter; text: "⌁  ◖  ◉"; color: "#eeeeee"; font.pixelSize: 15 }
    }
}
