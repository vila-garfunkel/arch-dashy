import Quickshell
import Quickshell.Hyprland
import QtQuick
import "services"
import "components"

ShellRoot {
    id: root

    MonitorManager { id: monitorManager }
    OverviewManager { id: overviewManager }
    DashManager { id: dashManager; overviewManager: overviewManager }
    WindowManager { id: windowManager }
    WorkspaceManager { id: workspaceManager; windowManager: windowManager }
    ApplicationManager { id: applicationManager }
    SearchManager { id: searchManager; applicationManager: applicationManager }

    GlobalShortcut {
        appid: "workflow-desktop"
        name: "overview"
        description: "Toggle desktop overview on every monitor"
        onPressed: overviewManager.toggle()
    }

    // Main-monitor-only top panel.
    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                visible: monitorManager.isMainScreen(modelData)
                anchors { top: true; left: true; right: true }
                implicitHeight: 38
                color: "#202124"
                exclusiveZone: 38
                aboveWindows: true
                TopPanel {
                    anchors.fill: parent
                    overviewManager: overviewManager
                    monitorManager: monitorManager
                    windowManager: windowManager
                }
            }
        }
    }

    // A full-screen overview surface is created for every monitor.
    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                visible: overviewManager.active
                anchors { top: true; bottom: true; left: true; right: true }
                color: "#d91b1c20"
                aboveWindows: true
                focusable: visible && monitorManager.isMainScreen(modelData)
                exclusionMode: ExclusionMode.Ignore

                MonitorOverview {
                    anchors.fill: parent
                    screen: modelData
                    isMain: monitorManager.isMainScreen(modelData)
                    overviewManager: overviewManager
                    dashManager: dashManager
                    windowManager: windowManager
                    workspaceManager: workspaceManager
                    applicationManager: applicationManager
                    searchManager: searchManager
                }
            }
        }
    }
}
