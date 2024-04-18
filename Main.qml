import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material 2.12
import "Api.js" as Api

Window {
  id: root
  width: 1600
  height: 1000
  visible: true

  property bool isSearching: false
  property bool openDetails: false
  property var showDetailsResult
  property var showId
  property bool busy: false
  property bool noResults: false

  FontLoader {
    id: webFont
    source: "https://www.1001fonts.com/download/font/uni-sans.heavy-italic-caps.otf"
  }

  Connections {
    target: searchContainer
    function onSearchStarted() {
      root.isSearching = true
    }
  }

  Connections {
    target: searchContainer
    function onSearchStopped() {
      root.isSearching = false
    }
  }

  Rectangle {
    id: main
    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }
    color: "black"

    SearchBar {
      id: searchContainer
    }

    Title {
      id: titleContainer
    }

    Trendings {}

    BusyIndicator {
      id: busyIndicator
      visible: busy
      anchors.centerIn: parent
      width: 281
      height: 281
      Material.accent: "#08FF5B"
    }

    Rectangle {
      id: searchResults
      anchors {
        top: searchContainer.bottom
        topMargin: 20
        bottom: parent.bottom
      }

      visible: isSearching && !openDetails && !busy
      opacity: visible ? 1 : 0

      height: root.height
      width: root.width
      color: "#0a090c"

      Behavior on opacity {
        NumberAnimation {
          duration: 1000
        }
      }

      NoResults {
        visible: noResults
        anchors.centerIn: parent
        width: 281
        height: 281
      }

      ListView {
        id: showListView
        visible: !noResults
        anchors {
          fill: parent
        }
        orientation: Qt.Horizontal
        spacing: 40

        delegate: SearchResults {}
      }
    }
    ShowDetails {
      id: showDetails
      anchors {
        top: root.top
        bottom: root.bottom
      }
    }
  }
}
