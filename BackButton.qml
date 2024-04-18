import QtQuick

Rectangle {
  id: backButton
  y: 80
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

  Behavior on color {
    ColorAnimation {
      duration: 100
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      openDetails = false
      isSearching = false
      showDetailsResult = {}
    }

    hoverEnabled: true
    onEntered: backButton.color = "#08FF5B"
    onExited: backButton.color = "white"
  }
}
