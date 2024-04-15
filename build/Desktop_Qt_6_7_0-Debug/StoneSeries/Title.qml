import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
  id: title

  width: parent.width
  height: 80
  color: "#99d98c"

  border.color: "black"

  FontLoader {
    id: webFont
    source: "https://www.1001fonts.com/download/font/ethnocentric.rg-regular.otf"
  }
  Text {

    text: "Stone Series"
    anchors.centerIn: parent
    font.pixelSize: 36
    color: "white"
    font.family: webFont.font.family

    //font.family: "Manjari Thin"
    //font.bold: true
  }
}
