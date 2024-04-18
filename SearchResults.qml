import QtQuick

Rectangle {
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

        maximumLineCount: 2
        width: searchedShowImage.width
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
