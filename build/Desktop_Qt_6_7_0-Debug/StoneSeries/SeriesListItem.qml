import QtQuick 2.15

Rectangle {
  property var model

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

          text: modelData.show.rating.average ? "Rating: " + modelData.show.rating.average.toString(
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
