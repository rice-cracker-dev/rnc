import QtQuick 6.8
import QtQuick.Layouts 6.8
import Quickshell.Services.SystemTray
import "../components"

RowLayout {
  spacing: 4

  Repeater {
    model: SystemTray.items

    QsImageButton {
      required property SystemTrayItem modelData;

      id: trayButton

      ghosted: true;

      source: modelData.icon

      imageWidth: 16
      imageHeight: 16

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        
        onClicked: (mouse) => {
          mouse.accepted = true;

          if (mouse.button == Qt.LeftButton) {
            trayButton.modelData.activate()
          } else if (mouse.button == Qt.MiddleButton) {
            trayButton.modelData.secondaryActivate()
          }
        }
      }
    }
  }
}
