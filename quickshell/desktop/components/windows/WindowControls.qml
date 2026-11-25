import QtQuick
import QtQuick.Controls

Row {
    required property var windowManager
    required property string address
    spacing: 4
    ToolButton { text: "−"; onClicked: { /* Minimize policy to be finalized: Wayland has no universal minimize request. */ } }
    ToolButton { text: "□"; onClicked: windowManager.toggleFloating(address) }
    ToolButton { text: "×"; onClicked: windowManager.close(address) }
}
