import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
  id: showDetailsRoot
  z: 3

  FontLoader {
    id: webFont
    source: "https://www.1001fonts.com/download/font/uni-sans.heavy-italic-caps.otf"
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

      width: 100
      height: 30

      Text {
        color: "black"
        text: "← Voltar"
      }

      onClicked: {
        openDetails = false
        isSearching = false
        showDetailsResult = {}
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

      Rectangle {
        x: 4
        anchors.top: seriesDetailsImage.bottom

        Text {
          id: seriesDetailsName
          color: "white"
          font.family: webFont.font.family

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
            topMargin: 10
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

          width: seriesDetailsImage.width

          text: showDetailsResult.summary

          wrapMode: Text.Wrap
          color: "white"
          font.pixelSize: 16
          clip: true

          horizontalAlignment: Text.AlignJustify
        }
      }
    }
  }
}
