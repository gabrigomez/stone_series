import QtQuick
import QtQuick.Controls
import "Api.js" as Api

Rectangle {
  id: showDetails
  visible: openDetails
  width: parent.width
  height: parent.height

  Button {
    id: closeButton
    anchors {
      top: titleContainer.bottom
    }

    width: 200
    height: 200

    Text {
      color: "black"
      text: "Fechar"
    }

    onClicked: {
      openDetails = false
      isSearching = false
    }
  }

  Rectangle {
    anchors {
      top: closeButton.bottom
    }

    Rectangle {
      color: "yellow"
      width: 500
      height: 900

      Image {
        id: seriesImage

        //sourceSize.width: 900
        //sourceSize.height: 600
        sourceSize.width: 600
        sourceSize.height: 650

        source: showDetailsResult
                && showDetailsResult.image ? showDetailsResult.image.orignal : ""
      }

      Text {
        anchors {
          top: seriesImage.bottom
        }
        text: showDetailsResult
              && showDetailsResult.name ? showDetailsResult.name : ""
        font.pixelSize: 44
      }
    }
  }
}
