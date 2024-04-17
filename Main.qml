import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material 2.12
import "Api.js" as Api

Window {
  id: root
  width: 600
  height: 1000
  visible: true

  property bool isSearching: false
  property bool openDetails: false
  property var showDetailsResult
  property var showId
  property bool busy: false
  property bool noResults: false

  FontLoader {
    id: webFont
    source: "https://www.1001fonts.com/download/font/uni-sans.heavy-italic-caps.otf"
  }

  Connections {
    target: searchContainer
    function onSearchStarted() {
      root.isSearching = true
    }
  }

  Connections {
    target: searchContainer
    function onSearchStopped() {
      root.isSearching = false
    }
  }

  Rectangle {
    id: main
    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }
    color: "black"

    SearchBar {
      id: searchContainer
      z: 1
    }

    Title {}

    Trendings {}

    BusyIndicator {
      id: busyIndicator
      visible: busy
      anchors.centerIn: parent
      width: 281
      height: 281
      Material.accent: "#08FF5B"
    }

    Rectangle {
      id: searchResults
      anchors {
        top: searchContainer.bottom
        topMargin: 20
        bottom: parent.bottom
      }

      visible: isSearching && !openDetails && !busy
      opacity: visible ? 1 : 0

      height: root.height
      width: root.width
      color: "#0a090c"

      Behavior on opacity {
        NumberAnimation {
          duration: 1000
        }
      }

      NoResults {
        visible: noResults
        anchors.centerIn: parent
        width: 281
        height: 281
      }

      ListView {
        id: showListView
        visible: !noResults
        anchors {
          fill: parent
        }
        orientation: Qt.Horizontal
        spacing: 40

        delegate: Rectangle {
          id: searchedShowCards
          color: "#08FF5B"
          border.color: "white"
          border.width: 2

          topRightRadius: 5
          topLeftRadius: 5
          bottomRightRadius: 20
          bottomLeftRadius: 20

          width: 512
          height: 820

          Rectangle {
            x: 6
            Image {
              id: searchedShowImage
              y: 2
              source: modelData.show.image ? modelData.show.image.original : "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg"
              width: 500
              height: 650
            }

            Rectangle {
              x: 4
              anchors {
                top: searchedShowImage.bottom
                topMargin: 10
              }
              color: "transparent"
              width: 500
              height: 100

              Text {
                id: searchedShowTitle
                color: "white"
                text: modelData.show.name
                style: Text.Outline
                styleColor: "black"
                wrapMode: Text.Wrap
                font.family: webFont.font.family
                font.pixelSize: 40
                width: searchedShowImage.width
                maximumLineCount: 2
                height: 100
              }

              Text {
                anchors {
                  top: searchedShowTitle.bottom
                }
                color: "black"
                text: modelData.show.rating.average ? modelData.show.rating.average.toString(
                                                        ) + "/10" : "Sem avaliação"

                style: Text.Outline
                styleColor: "white"
                font.family: webFont.font.family
                font.pixelSize: 26
              }
            }
          }
          MouseArea {
            anchors.fill: parent
            onClicked: {
              var showUrl = modelData.show.id
              Api.fetchShowDetails(showUrl, function (result) {
                showDetailsResult = result
              })
              openDetails = true
            }
          }
        }
      }
    }
  }

  ShowDetails {
    id: showDetails
    anchors {
      top: root.top
      bottom: root.bottom
    }
  }
}
