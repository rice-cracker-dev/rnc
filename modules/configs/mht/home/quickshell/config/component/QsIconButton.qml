import QtQuick

QsBaseButton {
  id: root
  property color iconColor: root.textColor
  property bool square: false

  contentItem: Item {
    id: content

    implicitWidth: root.square ? childrenRect.height : childrenRect.width
    implicitHeight: childrenRect.height

    QsIcon {
      id: contentIcon

      source: root.icon.source
      size: root.icon.height
      color: root.iconColor

      anchors.centerIn: parent
    }

    QsLabel {
      id: contentText

      anchors {
        left: contentIcon.right
        verticalCenter: contentIcon.verticalCenter
        leftMargin: root.spacing
      }

      text: root.text
      color: root.textColor
    }
  }
}
