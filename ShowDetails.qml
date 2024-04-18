import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
  id: showDetailsRoot
  visible: openDetails && !busy
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

  BackButton {
    y: 60
    x: 10
    z: 2
  }

  Rectangle {
    id: showDetailsCard
    anchors {
      top: root.top
      topMargin: 10
    }
    color: "transparent"
    y: 10
    width: root.width
    height: root.height

    Rectangle {
      color: "#08FF5B"
      anchors {
        horizontalCenter: showDetailsCard.horizontalCenter
      }

      border.color: "white"
      border.width: 2
      topRightRadius: 5
      topLeftRadius: 5
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
          source: showDetailsResult
                  && showDetailsResult.image ? showDetailsResult.image.original : 'https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg'
        }

        Text {
          id: showDetailsName
          anchors {
            top: showDetailsImage.bottom
            topMargin: 10
            bottomMargin: 10
          }

          text: showDetailsResult
                && showDetailsResult.name ? showDetailsResult.name : ''
          color: "white"
          style: Text.Outline
          styleColor: "black"
          font.family: webFont.font.family
          font.pixelSize: 44

          wrapMode: Text.WrapAtWordBoundaryOrAnywhere
          maximumLineCount: 2
          width: showDetailsImage.width
          height: 100
        }

        Row {
          id: showGenresRow
          anchors.top: showDetailsName.bottom
          spacing: 2

          Repeater {
            id: showGenresRepeater
            model: showDetailsResult ? showDetailsResult.genres : []
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

          text: showDetailsResult
                && showDetailsResult.rating ? (showDetailsResult.rating.average ? showDetailsResult.rating.average.toString() + "/10" : "Sem avaliação") : "Sem avaliação"
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
          text: showDetailsResult
                && showDetailsResult.summary ? showDetailsResult.summary : ''
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
