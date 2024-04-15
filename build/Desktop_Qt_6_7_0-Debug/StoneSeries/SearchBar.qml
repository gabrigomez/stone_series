import QtQuick
import QtQuick.Controls
import "Api.js" as Api

Rectangle {
  id: searchContainer
  property bool isSearching: false

  signal searchStarted
  signal searchStopped

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

    onTextChanged: {
      if (text === "") {
        isSearching = false
        searchStopped()
      }
    }

    Image {
      anchors.verticalCenter: parent.verticalCenter

      source: !isSearching ? "https://static-00.iconduck.com/assets.00/search-icon-2048x2048-cmujl7en.png" : 'https://cdn-icons-png.flaticon.com/512/106/106830.png'
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
