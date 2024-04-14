import QtQuick
import QtQuick.Controls
import "Api.js" as Api

Rectangle {
  id: searchContainer

  signal searchStarted

  color: "red"
  width: parent.width
  height: 40

  anchors {
    left: parent.left
    right: parent.right
    margins: 10
  }

  TextInput {
    id: searchInput

    anchors.fill: parent
    verticalAlignment: TextInput.AlignVCenter

    font.pixelSize: 18
    color: "white"
    leftPadding: 4

    Button {
      text: "Pesquisar"
      anchors.verticalCenter: parent.verticalCenter

      onClicked: {
        Api.fetchShows(searchInput.text)
        searchStarted()
      }
      anchors {
        right: parent.right
        margins: 10
      }
    }
  }
}
