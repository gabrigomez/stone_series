import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
  color: "transparent"
  Text {
    id: noResultsMessage
    text: "Nenhum resultado encontrado."
    anchors.horizontalCenter: parent.horizontalCenter
    color: "white"
    font.pixelSize: 30
  }

  Rectangle {
    id: backButtonContainer
    anchors {
      horizontalCenter: parent.horizontalCenter
      top: noResultsMessage.bottom
      topMargin: 16
    }
    color: "white"

    width: 60
    height: 60
    radius: 25

    Image {
      source: "https://static.thenounproject.com/png/1165042-200.png"
      height: 30
      width: 30

      anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
      }
    }

    Behavior on color {
      ColorAnimation {
        duration: 100
      }
    }

    MouseArea {
      anchors.fill: backButtonContainer
      onClicked: {
        noResults = false
        openDetails = false
        isSearching = false
        showDetailsResult = {}
      }

      hoverEnabled: true
      onEntered: backButtonContainer.color = "gray"
      onExited: backButtonContainer.color = "white"
    }
  }
}
