import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
  id: title

  width: parent.width
  height: 80
  color: "#99d98c"

  border.color: "black"

  Text {
    text: "Stone Series"
    anchors.centerIn: parent
    font.pixelSize: 36
    color: "white"
  }
}
