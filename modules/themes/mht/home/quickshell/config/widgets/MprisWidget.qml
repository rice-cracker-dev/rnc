import QtQuick 6.8
import QtQuick.Layouts 6.8
import Quickshell
import Quickshell.Services.Mpris
import "../components"

QsBaseButton {
  required property PanelWindow window;
  property MprisPlayer first: Mpris.players.values[0]
  
  id: root

  PersistentProperties {
    id: persist
    reloadableId: "persistedStates"

    property bool active: false
  }

  ghosted: true
  visible: !!first
  active: persist.active

  contentItem: RowLayout {
    QsIcon { code: 0xe405 }

    QsLabel {
      wrapMode: Text.Wrap
      elide: Text.ElideRight

      text: root.first?.trackTitle
    }
  }

  onClicked: () => (persist.active = !persist.active)
}
