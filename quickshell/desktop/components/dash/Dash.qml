import QtQuick
import Quickshell

Item {
    id: root
    signal showApplications()
    required property var screen
    required property var dashManager
    required property var overviewManager
    required property var applicationManager
    width: Math.min(440, parent ? parent.width - 40 : 440)
    height: 76
    visible: true
    opacity: root.overviewManager.active ? 1 : 0
    Behavior on opacity { NumberAnimation { duration: root.dashManager.animationDuration } }

    Rectangle {
        id: dock
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.overviewManager.active ? 0 : -90
        width: Math.min(root.width, 430)
        height: 68
        radius: 20
        color: "#cc42444a"
        border.color: "#66777a80"
        Row {
            anchors.centerIn: parent
            spacing: 10
            Repeater {
                model: Math.min(5, DesktopEntries.applications.count)
                delegate: Rectangle {
                    required property int index
                    width: 46; height: 46; radius: 12
                    color: "#53565e"
                    property var entry: DesktopEntries.applications.get(index)
                    Text { anchors.centerIn: parent; text: (parent.entry && parent.entry.name.length) ? parent.entry.name.substring(0,1).toUpperCase() : "•"; color: "white"; font.pixelSize: 20 }
                    MouseArea { anchors.fill: parent; onClicked: root.applicationManager.launch(parent.entry, root.screen.name) }
                }
            }
            Rectangle {
                width: 46; height: 46; radius: 12; color: "#656872"
                Text { anchors.centerIn: parent; text: "⠿"; color: "white"; font.pixelSize: 25 }
                MouseArea { anchors.fill: parent; onClicked: root.showApplications() }
            }
        }
    }
    Behavior on anchors.bottomMargin { NumberAnimation { duration: root.dashManager.animationDuration; easing.type: Easing.OutCubic } }
}
