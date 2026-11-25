import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    required property var searchManager
    required property var overviewManager
    required property string monitorName
    height: 44
    radius: 22
    color: "#414247"
    border.color: "#55575c"

    Row {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 10
        Text { anchors.verticalCenter: parent.verticalCenter; text: "⌕"; color: "#dddddd"; font.pixelSize: 20 }
        TextField {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 42
            placeholderText: "Type to search applications..."
            focus: root.visible
            text: root.overviewManager.mainSearchText
            color: "white"
            placeholderTextColor: "#b7b7bb"
            background: null
            onVisibleChanged: if (visible) forceActiveFocus()
            onTextChanged: {
                root.overviewManager.mainSearchText = text;
                root.searchManager.query = text;
                root.overviewManager.setPage(root.monitorName, text.length > 0 ? "search" : "workspaces");
            }
        }
    }
}
