import QtQuick
import QtQuick.Controls

Rectangle {
  color: "transparent"

  Text {
    id: noResultsMessage
    text: "Nenhum resultado encontrado."
    anchors.horizontalCenter: parent.horizontalCenter
    color: "white"
    font.pixelSize: 50
  }

  BackButton {
    anchors.horizontalCenter: parent.horizontalCenter
    height: 60
    width: 60
  }
}
