pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import "root:/common/fuzzysort.js" as Fuzzysort
import "root:/components"
import "root:/"

LazyLoader {
  activeAsync: LauncherService.open

  PanelWindow {
    Component.onCompleted: inputField.forceActiveFocus()

    color: "transparent"

    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "shell:launcher"

    implicitWidth: main.width
    implicitHeight: main.height

    Frame {
      id: main

      implicitWidth: 600

      background: Rectangle {
        color: Theme.background
        border {
          color: Theme.outline_variant
          width: 1
        }
      }

      contentItem: ColumnLayout {
        RowLayout {
          Layout.fillWidth: true
          spacing: 8

          Icon {
            id: iconField
            Layout.alignment: Qt.AlignVCenter
            icon: Qt.resolvedUrl("../../assets/magnify-symbolic.svg")
            size: 16
            color: inputField.color
          }

          Input {
            id: inputField
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            text: ""
            focus: true
            Keys.forwardTo: [itemList]
            Keys.onEscapePressed: LauncherService.open = false

            onAccepted: {
              if (itemList.currentItem) {
                itemList.currentItem.clicked(null);
              }
            }

            onTextChanged: {
              CalcService.calculateExpression(text);
            }
          }
        }

        ListView {
          id: itemList
          Layout.fillWidth: true
          Layout.preferredHeight: 320

          cacheBuffer: 0
          keyNavigationEnabled: true
          keyNavigationWraps: true
          preferredHighlightBegin: topMargin
          preferredHighlightEnd: height - bottomMargin
          highlightRangeMode: ListView.ApplyRange
          highlightResizeDuration: 0
          highlightMoveDuration: 0
          snapMode: ListView.SnapToItem
          clip: true

          section {
            property: "group"
            criteria: ViewSection.FirstCharacter
            delegate: Text {
              required property string section

              text: section
            }
          }

          highlight: Rectangle {
            color: Theme.surface_container
            border {
              color: Theme.outline_variant
              width: 1
            }
          }

          model: ScriptModel {
            values: {
              if (inputField.text.trim() === "") {
                return [];
              }

              const apps = Fuzzysort.go(inputField.text, DesktopEntries.applications.values, {
                key: 'name'
              }).map(app => ({
                    group: 'Applications',
                    title: app.obj.name,
                    description: app.obj.comment,
                    icon: {
                      type: 'icon',
                      source: Quickshell.iconPath(app.obj.icon ?? ""),
                      symbolic: false
                    },
                    execute: () => app.obj.execute()
                  }));

              const emojis = EmojiService.query(inputField.text).map(emoji => {
                return {
                  group: 'Emojis',
                  title: emoji.obj.name,
                  description: "Copy to clipboard",
                  icon: {
                    type: 'text',
                    text: emoji.obj.characters
                  },
                  execute: () => {
                    Quickshell.clipboardText = emoji.obj.characters;
                  }
                };
              });

              const calc = CalcService.code !== 0 ? null : {
                group: 'Calculation',
                title: CalcService.result,
                description: "Copy to clipboard",
                icon: {
                  type: 'icon',
                  source: Qt.resolvedUrl("../../assets/calculator-symbolic.svg"),
                  symbolic: true
                },
                execute: () => {
                  Quickshell.clipboardText = CalcService.result;
                }
              };

              const runCommand = inputField.text.trim() === "" ? null : {
                group: 'Command',
                title: inputField.text,
                description: "Run command in terminal",
                icon: {
                  type: 'icon',
                  source: Qt.resolvedUrl("../../assets/console-symbolic.svg"),
                  symbolic: true
                },
                execute: () => LauncherService.runCommand(["kitty", "--", ...inputField.text.split(" ")])
              };

              return [...apps, ...emojis, runCommand, calc].filter(e => e !== null);
            }
            onValuesChanged: {
              itemList.currentIndex = 0;
            }
          }

          delegate: MouseArea {
            id: item
            required property var modelData
            required property int index

            implicitWidth: ListView.view.width
            implicitHeight: childrenRect.height
            hoverEnabled: true

            onClicked: {
              modelData.execute();
              LauncherService.open = false;
            }

            onEntered: {
              itemList.currentIndex = index;
            }

            WrapperItem {
              margin: 8
              resizeChild: true

              width: parent.width

              Item {
                implicitHeight: childrenRect.height

                Item {
                  id: itemIcon
                  implicitWidth: 20
                  implicitHeight: 20

                  anchors.verticalCenter: itemTitle.verticalCenter

                  Icon {
                    icon: item.modelData.icon?.source ?? ""
                    size: parent.height
                    colorEnabled: !!item.modelData.icon?.symbolic
                    color: itemTitle.color
                    visible: item.modelData.icon.type === 'icon'
                  }

                  Text {
                    text: item.modelData.icon?.text ?? ""
                    font.pixelSize: parent.height
                    color: itemTitle.color
                    visible: item.modelData.icon.type === 'text'
                  }
                }

                Text {
                  id: itemTitle
                  anchors {
                    leftMargin: 8
                    left: itemIcon.right
                    right: parent.right
                  }
                  text: item.modelData.title
                }

                Text {
                  anchors {
                    top: itemTitle.bottom
                    left: itemTitle.left
                    right: itemTitle.right
                  }
                  text: item.modelData.description
                  font.pixelSize: 12
                  opacity: 0.5
                  elide: Text.ElideRight
                  height: !item.modelData.description ? 0 : undefined
                }
              }
            }
          }
        }
      }
    }
  }
}
