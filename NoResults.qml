import QtQuick
import QtQuick.Controls

Rectangle {
  color: "transparent"

  Text {
    id: noResultsMessage
    anchors.horizontalCenter: parent.horizontalCenter
    text: "Nenhum resultado encontrado."
    color: "white"
    font.pixelSize: 50
  }

  BackButton {
    anchors.horizontalCenter: parent.horizontalCenter
    height: 60
    width: 60
  }
}
