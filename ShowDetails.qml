import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
  id: showDetailsRoot
  z: 3

  property alias title: texttt.text

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
        id: texttt
        color: "black"
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

        text: showDetailsResult.summary
        wrapMode: Text.Wrap
        color: "white"
        font.pixelSize: 16
      }
    }
  }
}
