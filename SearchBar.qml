import QtQuick
import QtQuick.Controls
import "Api.js" as Api

Rectangle {
  id: searchContainer
  property bool isSearching: false
  signal searchStarted
  signal searchStopped

  height: 40
  color: "#0D1B2A"
  border.color: "white"

  width: parent.width / 3
  TextInput {
    id: searchInput

    anchors.fill: parent
    verticalAlignment: TextInput.AlignVCenter
    font.pixelSize: 18
    leftPadding: 6

    color: "white"

    onTextChanged: {
      if (text === "") {
        isSearching = false
        searchStopped()
      }
    }

    Image {
      anchors.verticalCenter: parent.verticalCenter
      source: !isSearching ? "https://static-00.iconduck.com/assets.00/search-icon-256x256-v6gfhlc1.png" : 'https://static.vecteezy.com/system/resources/previews/018/887/460/original/signs-close-icon-png.png'
      height: 20
      width: 20

      anchors {
        right: parent.right
        margins: 10
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          if (isSearching) {
            isSearching = false
            searchInput.text = ""
            searchStopped()
          } else {
            Api.fetchShows(searchInput.text)
            searchStarted()
          }
        }
      }
    }

    // Adiciona um listener para alterar isSearching quando searchStarted for emitido
    Connections {
      target: searchContainer
      onSearchStarted: {
        isSearching = true
      }
    }
  }
}
