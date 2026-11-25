import QtQuick

QtObject {
    property var overviewManager
    property int animationDuration: 260

    function isVisible() {
        return overviewManager ? overviewManager.active : false;
    }

    function launchTarget(screen) {
        return screen ? screen.name : "";
    }
}
