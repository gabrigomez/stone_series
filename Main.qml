import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "Api.js" as Api

Window {
  id: root
  width: 600
  height: 1000
  visible: true

  Title {
    id: titleContainer

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
      id: searchContainer
    }

    Rectangle {
      id: results

      anchors {
        top: searchContainer.bottom
        bottom: parent.bottom
      }

      height: 80
      width: parent.width
      color: "gray"

      ListView {
        id: showListView
        visible: !showDetailsListView
        spacing: 10

        anchors {
          fill: parent
        }

        model: ListModel {
          id: showModel
        }

        delegate: Rectangle {
          width: parent.width
          height: 100
          border.color: "blue"
          color: "transparent"
          Rectangle {
            anchors.fill: parent

            Image {
              id: seriesImage
              sourceSize.width: 300 // Tamanho da imagem
              sourceSize.height: 100 // Tamanho da imagem
              source: modelData.show.image.medium
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
              font.pixelSize: 22
              font.bold: true
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
                                                      ) : "Sem avaliação"
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
