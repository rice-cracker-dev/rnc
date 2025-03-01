import QtQuick 6.8

QsLabel {
  FontLoader {
    id: materialFont
    source: "../assets/fonts/material-icons.ttf"
  }

  required property int code
  property bool filled: true

  text: String.fromCharCode(code)
  renderType: Text.NativeRendering;
  
  font.family: materialFont.font.family
  font.variableAxes: {
    "FILL": filled ? 1 : 0
  }
}
