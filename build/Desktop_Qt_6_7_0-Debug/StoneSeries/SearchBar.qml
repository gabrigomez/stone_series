import QtQuick
import QtQuick.Controls
import "Api.js" as Api

Rectangle {
  id: searchContainer
  signal searchStarted

  height: 35
  border.color: "gray"
  opacity: 10

  color: "#0D1B2A"

  anchors {
    left: parent.left
    right: parent.right
    margins: 4
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
