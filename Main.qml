import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "Api.js" as Api

Window {
  id: root
  width: 600
  height: 1000
  visible: true

  color: "black"

  property bool isSearching: false
  property bool openDetails: false
  property var showDetailsResult

  property var showId

  Connections {
    target: searchContainer
    onSearchStarted: {
      root.isSearching = true
    }
  }

  Connections {
    target: searchContainer
    onSearchStopped: {
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

    Trending {}

    Rectangle {
      id: results
      height: 80
      width: root.width
      color: "#1B263B"

      anchors {
        top: searchContainer.bottom
        bottom: parent.bottom
      }

      visible: isSearching && !openDetails
      opacity: visible ? 1 : 0

      Behavior on opacity {
        NumberAnimation {
          duration: 1000
        }
      }

      ListView {
        id: showListView
        spacing: 10

        orientation: Qt.Horizontal

        anchors {
          fill: parent
        }

        delegate: Rectangle {
          width: 500
          height: 900
          color: "transparent"

          Rectangle {
            Image {
              id: seriesImage

              //sourceSize.width: 900
              //sourceSize.height: 600
              sourceSize.width: seriesImage.sourceSize.width
              sourceSize.height: 650

              source: modelData.show.image ? modelData.show.image.original : "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg"
            }

            Text {
              id: seriesTitle
              anchors {
                top: seriesImage.bottom
              }
              text: modelData.show.name
              font.pixelSize: 44
            }
            Text {
              anchors {
                bottom: parent.verticalCenter
                top: seriesTitle.bottom
                margins: 20
              }

              text: modelData.show.rating.average ? "Rating: "
                                                    + modelData.show.rating.average.toString(
                                                      ) + "/10" : "Sem avaliação"
              font.pixelSize: 16
            }
          }

          MouseArea {
            anchors.fill: parent
            onClicked: {
              var showUrl = modelData.show.id
              Api.fetchShowDetails(showUrl, function (result) {
                showDetailsResult = result
                console.log(showDetailsResult.image.original)
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
      top: searchContainer.bottom
      bottom: parent.bottom
    }
  }
}
