import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
  id: showListViewComponent

  property alias model: listView.model

  ListView {
    id: listView
    spacing: 10
    anchors.fill: parent

    model: ListModel {
      id: showModel
    }

    delegate: Rectangle {
      width: listView.width
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
          text: modelData.show.rating.average ? "Rating: " + modelData.show.rating.average.toString(
                                                  ) : "Sem avaliação"
          font.pixelSize: 16
        }

        MouseArea {
          anchors.fill: parent
          onClicked: {
            var showUrl = modelData.show.id
            fetchShowDetails(showUrl)
          }
        }
      }
    }
  }
}
