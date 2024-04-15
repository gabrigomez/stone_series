import QtQuick
import QtQuick.Controls
import "Api.js" as Api

Rectangle {
  id: searchContainer

  signal searchStarted
  height: 40

  x: 40

  width: parent.width / 2
  TextInput {
    id: searchInput

    anchors.fill: parent
    verticalAlignment: TextInput.AlignVCenter
    font.pixelSize: 18
    color: "black"
    leftPadding: 4

    Image {
      //text: "Pesquisar"
      anchors.verticalCenter: parent.verticalCenter

      source: "https://static-00.iconduck.com/assets.00/search-icon-2048x2048-cmujl7en.png"
      height: 20
      width: 20

      anchors {
        right: parent.right
        margins: 10
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          Api.fetchShows(searchInput.text)
          searchStarted()
        }
      }
    }
  }
}
