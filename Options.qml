import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

ScrollView {
    id: page
    //    implicitWidth: 640
    //    implicitHeight: 200
    signal nobtn
    signal switchMem(bool on)
    signal switchCpu(bool on);
    horizontalScrollBarPolicy: 0
    property bool memWid


    Image {
        id: content
        source: "image://ThemeProvider/bg"
        width: Math.max(page.viewport.width, grid.implicitWidth + 2 * grid.rowSpacing)
        height: Math.max(page.viewport.height, grid.implicitHeight + 2 * grid.columnSpacing)

        GridLayout {
            id: grid

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: grid.rowSpacing
            anchors.rightMargin: grid.rowSpacing
            anchors.topMargin: grid.columnSpacing

            columns: page.width < page.height ? 1 : 2

            GroupBox {
                title: qsTr("Settings")
                Layout.fillWidth: true
                Layout.columnSpan: grid.columns
                ColumnLayout {
                    anchors.fill: parent
                    RowLayout {
                        Label { text: "ROOT"; Layout.fillWidth: true }
                        Switch {
                            id: rootSwitch;
                            checked: mc.boolValue("user/root");
                            onClicked: {
                                mc.setBoolValue("user/root", checked);
                                mc.setShell(checked);
                            }
                        }
                    }
                    RowLayout {
                        Label { text: qsTr("show memory info"); Layout.fillWidth: true }

                        Switch {
                            id: memSwitch;
                            checked: mc.boolValue("user/memInfo");
                            onClicked: {
                                page.switchMem(checked);
                                mc.setBoolValue("user/memInfo", checked)
                            }
                        }
                    }

                    RowLayout {
                        width: 100
                        height: 100

                        Label {
                            text: qsTr("show cpu info")
                            Layout.fillWidth: true
                        }
                        Switch {
                            id:cpuSwitch;
                            checked: mc.boolValue("user/cpuInfo");
                            onClicked: {
                                page.switchCpu(checked);
                                mc.setBoolValue("user/cpuInfo", checked)
                            }
                        }
                    }

                    RowLayout {
                        width: 100
                        height: 100

                        Label {
                            text: qsTr("visible file items(7-25)")
                            Layout.fillWidth: true
                        }
                        SpinBox { id: itemnum; value: mc.intValue("user/itemNum"); minimumValue: 7; maximumValue: 25; Layout.fillWidth: false }
                    }

                    RowLayout {
                        width: 100
                        height: 100
                        Layout.fillWidth: true

                        Label {
                            text: qsTr("text color")
                            Layout.fillWidth: true
                        }
                        TextField { id: txtcolor; text: mc.colorValue("user/textColor"); Layout.fillWidth: false}
                    }
                }
            }

            RowLayout {
                width: 100
                height: 100

                Button {
                    id: button1
                    text: qsTr("Back")
                    onClicked: page.nobtn()
                }

                Item {
                    id: item1
                    width: 200
                    height: 200
                    Layout.fillWidth: true
                }

                Button {
                    id: button2
                    text: qsTr("Save")
                    onClicked: {
                        mc.setIntValue("user/itemNum", itemnum.value);
                        mc.setColorValue("user/textColor", txtcolor.getText(0, txtcolor.length));
                    }
                }
            }
        }
    }
}
