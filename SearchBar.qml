import QtQuick
import QtQuick.Controls
import "Api.js" as Api

Rectangle {
  id: searchContainer
  property bool isSearching: false
  signal searchStarted
  signal searchStopped

  color: "#0D1B2A"
  border.color: "gray"
  x: 2
  y: 4
  z: 3

  height: 40
  width: parent.width / 3.5

  TextInput {
    id: searchInput

    anchors.fill: parent
    verticalAlignment: TextInput.AlignVCenter
    font.pixelSize: 18
    leftPadding: 2
    rightPadding: 40
    color: "white"

    onTextChanged: {
      if (text === "") {
        isSearching = false
        searchStopped()
      }
    }

    Image {
      source: "https://static-00.iconduck.com/assets.00/search-icon-256x256-v6gfhlc1.png"
      height: 20
      width: 20

      anchors {
        right: parent.right
        margins: 10
        verticalCenter: parent.verticalCenter
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

  Connections {
    target: searchContainer
    function onSearchStarted() {
      isSearching = true
      openDetails = false
    }
  }
}
