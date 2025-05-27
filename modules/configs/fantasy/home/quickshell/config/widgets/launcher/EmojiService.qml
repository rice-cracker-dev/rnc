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
    const mapped = Object.entries(json).map(([raw, data]) => {
      return {
        raw,
        name: data.name,
        slug: data.slug,
        group: data.group
      };
    });

    return mapped;
  }

  function query(str) {
    return Fuzzysort.go(str, emojis, {
      key: "name"
    });
  }
}
