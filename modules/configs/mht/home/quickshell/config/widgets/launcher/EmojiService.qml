pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "root:/common/fuzzysort.js" as Fuzzysort

Singleton {
  FileView {
    id: jsonFile
    path: Qt.resolvedUrl("./emoji.json")
    blockLoading: true
  }

  readonly property var emojis: {
    const json = JSON.parse(jsonFile.text());
    return json;
  }

  function query(str) {
    const result = Fuzzysort.go(str, emojis, {
      key: 'name',
      limit: 1
    });

    console.log(result);

    return result;
  }
}
