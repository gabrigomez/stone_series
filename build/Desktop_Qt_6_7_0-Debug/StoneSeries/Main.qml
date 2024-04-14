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

    color: "green"

    SearchBar {
      z: 1
      id: searchContainer
    }

    Connections {
      target: searchContainer
      onSearchStarted: {
        root.isSearching = true
      }
    }

    Trending {}

    Rectangle {
      id: results

      anchors {
        top: searchContainer.bottom
        bottom: parent.bottom
      }

      visible: isSearching
      opacity: visible ? 1 : 0

      Behavior on opacity {
        NumberAnimation {
          duration: 1000
        }
      }

      height: 80
      width: parent.width
      color: "gray"

      ListView {
        id: showListView
        spacing: 10

        anchors {
          fill: parent
        }

        model: ListModel {
          id: showModel
        }

        delegate: Rectangle {
          width: parent ? parent.width / 1.2 : undefined
          height: 300
          radius: 70

          anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined

          //border.color: "blue"
          //color: "transparent"
          Rectangle {
            anchors.fill: parent
            anchors.centerIn: parent
            color: "transparent"

            Image {
              id: seriesImage
              sourceSize.width: parent.width / 1.2
              sourceSize.height: 300

              source: modelData.show.image ? modelData.show.image.medium : "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg"
            }

            Text {
              id: serieTitle

              anchors {
                bottom: parent.verticalCenter
                left: seriesImage.right
                margins: 20
                right: parent.right
              }

              text: modelData.show.name
              font.pixelSize: 36
              font.bold: true
              wrapMode: Text.WordWrap
            }
            Text {
              anchors {
                bottom: parent.verticalCenter
                top: serieTitle.bottom
                left: seriesImage.right
                margins: 20
                right: parent.right
              }

              text: modelData.show.rating.average ? "Rating: "
                                                    + modelData.show.rating.average.toString(
                                                      ) + "/10" : "Sem avaliação"
              font.pixelSize: 16
            }
            MouseArea {
              anchors.fill: parent
              onClicked: {
                var showUrl = modelData.show.id
                Api.fetchShowDetails(showUrl)
              }
            }
          }
        }
      }
    }
  }
}
