import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property var modelData
            screen: modelData

            anchors { top: true; left: true; right: true }
            implicitHeight: 32
            color: "#1a1b26"

            // Theme
            property color colBg: "#1a1b26"
            property color colFg: "#a9b1d6"
            property color colMuted: "#444b6a"
            property color colActive: "#7aa2f7"
            property color colWarn: "#f7768e"
            property string fontFamily: "JetBrainsMono Nerd Font"

            // Keeps Pipewire tracking the default audio sink so volume updates live
            PwObjectTracker {
                objects: [ Pipewire.defaultAudioSink ]
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                // ---------------- Workspaces ----------------
                RowLayout {
                    spacing: 4
                    Repeater {
                        model: 9
                        Text {
                            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                            property bool isActive: Hyprland.focusedWorkspace?.id === index + 1

                            text: (index + 1).toString()
                            visible: ws !== undefined
                            color: isActive ? root.colActive : root.colFg
                            font.bold: isActive
                            font.family: root.fontFamily
                            font.pixelSize: 14

                            MouseArea {
                                anchors.fill: parent
                                onClicked: Hyprland.dispatch(`workspace ${index + 1}`)
                            }
                        }
                    }
                }

                Item { Layout.fillWidth: true } // spacer pushes everything below to the right

                // ---------------- Clock ----------------
                Text {
                    id: clock
                    property string time: ""
                    text: time
                    color: root.colFg
                    font.family: root.fontFamily
                    font.pixelSize: 14

                    Process {
                        id: dateProc
                        command: ["date", "+%H:%M  %a %d %b"]
                        running: true
                        stdout: StdioCollector {
                            onStreamFinished: clock.time = this.text.trim()
                        }
                    }
                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: dateProc.running = true
                    }
                }

                // ---------------- WiFi ----------------
                Text {
                    id: wifi
                    property string ssid: ""
                    text: (ssid !== "" ? "󰤨 " + ssid : "󰤭 off")
                    color: root.colFg
                    font.family: root.fontFamily
                    font.pixelSize: 14

                    Process {
                        id: wifiProc
                        command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"]
                        running: true
                        stdout: StdioCollector {
                            onStreamFinished: wifi.ssid = this.text.trim()
                        }
                    }
                    Timer {
                        interval: 5000
                        running: true
                        repeat: true
                        onTriggered: wifiProc.running = true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Quickshell.execDetached(["nm-connection-editor"])
                    }
                }

                // ---------------- Volume ----------------
                Text {
                    id: volume
                    property var sink: Pipewire.defaultAudioSink
                    text: {
                        if (!sink || !sink.audio) return "󰝟"
                        if (sink.audio.muted) return "󰝟 muted"
                        return "󰕾 " + Math.round(sink.audio.volume * 100) + "%"
                    }
                    color: root.colFg
                    font.family: root.fontFamily
                    font.pixelSize: 14

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: (mouse) => {
                            if (mouse.button === Qt.RightButton && volume.sink && volume.sink.audio) {
                                volume.sink.audio.muted = !volume.sink.audio.muted
                            }
                        }
                        onWheel: (wheel) => {
                            if (!volume.sink || !volume.sink.audio) return
                            let step = 0.05
                            let cur = volume.sink.audio.volume
                            volume.sink.audio.volume = Math.max(0, Math.min(1,
                                cur + (wheel.angleDelta.y > 0 ? step : -step)))
                        }
                    }
                }

                // ---------------- Battery ----------------
                Text {
                    id: battery
                    property var dev: UPower.displayDevice
                    visible: dev && dev.isLaptopBattery
                    text: {
                        if (!dev) return ""
                        let pct = Math.round(dev.percentage * 100)
                        let icon = dev.state === UPowerDeviceState.Charging ? "󰂄" : "󰁹"
                        return icon + " " + pct + "%"
                    }
                    color: (dev && dev.percentage < 0.2 && dev.state !== UPowerDeviceState.Charging)
                           ? root.colWarn : root.colFg
                    font.family: root.fontFamily
                    font.pixelSize: 14
                }
            }
        }
    }
}
