import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
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

  Title {
    id: titleContainer
    z: 1
    anchors {
      top: root.top
      left: root.left
      right: root.right
    }
  }

  Rectangle {
    id: main

    anchors {
      top: titleContainer.bottom
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }

    color: "#0D1B2A"

    SearchBar {
      id: searchContainer
      z: 1
    }

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

        //model: ListModel {
        //id: showModel
        //}
        delegate: Rectangle {
          width: 500
          height: 900
          color: "gray"

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

  Rectangle {
    id: showDetails
    visible: openDetails
    x: root.x
    y: root.y
    z: 3
    height: root.height
    width: root.width
    color: "#1B263B"

    anchors {
      top: searchContainer.bottom
      bottom: parent.bottom
    }

    Button {
      id: closeButton

      width: 200
      height: 30

      Text {
        color: "black"
        text: "Voltar"
      }

      onClicked: {
        openDetails = false
        isSearching = false
      }
    }

    Rectangle {
      width: root.width
      height: 900
      color: "transparent"

      anchors {
        top: closeButton.bottom
      }

      Image {
        id: seriesDetailsImage

        sourceSize.width: 600
        sourceSize.height: 650
        source: showDetailsResult.image.original
      }

      Text {
        id: seriesDetailsName
        color: "white"

        anchors {
          top: seriesDetailsImage.bottom
          topMargin: 10
          bottomMargin: 10
        }
        text: showDetailsResult.name
        font.pixelSize: 44
      }
      Row {
        id: genresRow
        anchors.top: seriesDetailsName.bottom
        spacing: 2

        Repeater {
          id: genresRepeater
          model: showDetailsResult.genres
          Text {
            text: modelData + (index < genresRepeater.count - 1 ? ", " : "")
            font.pixelSize: 24
            color: "white"
            wrapMode: Text.Wrap
          }
        }
      }
      Text {
        id: seriesDetailsRating
        color: "white"

        anchors {
          top: genresRow.bottom
          topMargin: 100
          bottomMargin: 10
        }

        text: showDetailsResult.rating.average ? +showDetailsResult.rating.average.toString(
                                                   ) + "/10" : "Sem avaliação"
        font.pixelSize: 16
      }
      Text {
        id: seriesDetailsSummary
        anchors {
          top: seriesDetailsRating.bottom
          topMargin: 10
          bottomMargin: 10
        }

        text: showDetailsResult.summary
        wrapMode: Text.Wrap
        color: "white"
        font.pixelSize: 16
      }
    }
  }
}
