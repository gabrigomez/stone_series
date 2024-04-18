import QtQuick
import QtQuick.Controls

Rectangle {
  anchors {
    top: parent.top
    right: parent.right
  }
  color: "transparent"
  z: 3
  width: 180
  height: 50

  Image {
    source: "https://cdn-icons-png.flaticon.com/512/1709/1709973.png"
    y: 12
    anchors.right: parent.right
    anchors.rightMargin: 10

    width: 25
    height: 25
  }

  Text {
    color: "white"
    y: 16
    text: "Stone Series"
    style: Text.Outline

    styleColor: "#08FF5B"
    font.family: "Manjari Thin"
    font.pixelSize: 24
    font.bold: true
  }
}
