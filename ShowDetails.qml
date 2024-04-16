import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
  id: showDetailsRoot
  visible: openDetails
  color: "black"
  width: root.width
  height: root.height

  anchors {
    top: root.top
    bottom: root.bottom
  }

  FontLoader {
    id: webFont
    source: "https://www.1001fonts.com/download/font/uni-sans.heavy-italic-caps.otf"
  }

  Rectangle {
    id: closeButton
    y: 20
    x: 10
    z: 2

    width: 50
    height: 50
    radius: 25

    Image {
      source: "https://static.thenounproject.com/png/1165042-200.png"
      height: 25
      width: 25

      anchors {
        right: parent.right
        margins: 10
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
      }
    }

    MouseArea {
      anchors.fill: parent
      onClicked: {
        openDetails = false
        isSearching = false
        showDetailsResult = {}
      }
    }
  }

  Rectangle {
    id: showDetailsCard
    anchors {
      top: root.top
      topMargin: 10
    }
    color: "transparent"
    width: root.width
    height: root.height

    Rectangle {
      color: "#08FF5B"
      anchors {
        horizontalCenter: showDetailsCard.horizontalCenter
      }

      border.color: "white"
      border.width: 2
      bottomRightRadius: 20
      bottomLeftRadius: 20

      width: 512
      height: 920

      Rectangle {
        x: 6
        y: 4

        Image {
          id: showDetailsImage
          width: 500
          height: 600
          source: showDetailsResult.image.original
        }

        Text {
          id: showDetailsName
          anchors {
            top: showDetailsImage.bottom
            topMargin: 10
            bottomMargin: 10
          }

          text: showDetailsResult.name
          color: "white"
          style: Text.Outline
          styleColor: "black"
          font.family: webFont.font.family
          font.pixelSize: 44

          wrapMode: Text.WrapAtWordBoundaryOrAnywhere
          width: showDetailsImage.width
        }

        Row {
          id: showGenresRow
          anchors.top: showDetailsName.bottom
          spacing: 2

          Repeater {
            id: showGenresRepeater
            model: showDetailsResult.genres
            Text {
              text: modelData + (index < showGenresRepeater.count - 1 ? ", " : "")
              color: "black"
              font.pixelSize: 24
              wrapMode: Text.Wrap
            }
          }
        }

        Text {
          id: seriesDetailsRating
          anchors {
            top: showGenresRow.bottom
            topMargin: 10
            bottomMargin: 10
          }

          text: showDetailsResult.rating.average ? +showDetailsResult.rating.average.toString(
                                                     ) + "/10" : "Sem avaliação"
          color: "white"
          style: Text.Outline
          styleColor: "black"
          font.family: webFont.font.family
          font.pixelSize: 16
        }

        Text {
          id: showDetailsSummary
          anchors {
            top: seriesDetailsRating.bottom
            topMargin: 10
            bottomMargin: 10
          }
          text: showDetailsResult.summary
          color: "black"
          wrapMode: Text.Wrap
          font.pixelSize: 16

          clip: true
          maximumLineCount: 7
          horizontalAlignment: Text.AlignJustify
          width: showDetailsImage.width
        }
      }
    }
  }
}
