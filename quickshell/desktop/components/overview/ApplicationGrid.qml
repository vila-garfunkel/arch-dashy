import QtQuick
import QtQuick.Controls
import Quickshell

Item {
    id: root
    required property var applicationManager
    required property var searchManager
    required property var windowManager
    required property var screen
    property bool isSearch: false

    GridView {
        anchors.fill: parent
        cellWidth: 126
        cellHeight: 112
        clip: true
        model: DesktopEntries.applications
        delegate: Item {
            required property var modelData
            width: 116; height: 104
            visible: !root.isSearch || root.searchManager.matches(modelData)
            Rectangle {
                anchors.fill: parent
                radius: 12
                color: mouse.containsMouse ? "#555963" : "#30333a"
                opacity: 0.96
            }
            Column {
                anchors.centerIn: parent
                spacing: 7
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 42; height: 42
                    source: modelData.icon ? Quickshell.iconPath(modelData.icon) : ""
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    width: 104
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData.name
                    color: "#f2f3f5"
                    font.pixelSize: 11
                    elide: Text.ElideRight
                }
            }
            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.applicationManager.launch(modelData, root.screen.name)
            }
        }
    }
}
