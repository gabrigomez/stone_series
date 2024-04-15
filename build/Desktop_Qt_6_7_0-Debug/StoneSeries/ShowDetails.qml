import QtQuick
import QtQuick.Controls

Rectangle {
  visible: openDetails
  width: parent.width
  height: parent.height

  color: "black"

  Button {
    Text {
      text: Fechar
    }

    onClicked: {
      openDetails = false
      isSearching = false
    }
  }
}
