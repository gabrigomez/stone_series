import QtQuick
import QtQuick.Layouts

Rectangle {
  id: trendingContainer
  width: parent.width
  height: 40

  visible: !isSearching
  anchors {
    top: searchContainer.bottom
  }

  FontLoader {
    id: webFont
    source: "https://www.1001fonts.com/download/font/uni-sans.heavy-italic-caps.otf"
  }

  Rectangle {
    id: trendingTitleContainer
    width: parent.width
    height: 80
    color: "#1B263B"
    z: 1

    Text {
      id: trendingTitle
      color: "white"
      anchors.centerIn: parent
      text: "Em alta"
      font.pixelSize: 40
      font.bold: true
    }
  }

  Rectangle {
    visible: true
    width: root.width
    height: 900

    color: "transparent"
    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
    anchors {
      top: trendingTitleContainer.bottom
    }

    ListView {
      anchors.fill: parent
      orientation: Qt.Horizontal
      model: ListModel {
        ListElement {
          showName: "The Office"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/481/1204342.jpg"
          rating: 8.5
          id_: 526
        }
        ListElement {
          showName: "Breaking Bad"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/501/1253519.jpg"
          rating: 9.2
          id_: 169
        }
        ListElement {
          showName: "The Big Bang Theory"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/173/433868.jpg"
          rating: 8
          id_: 66
        }
        ListElement {
          showName: "The Walking Dead"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/424/1061900.jpg"
          rating: 8
          id_: 73
        }
        ListElement {
          showName: "Stranger Things"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/396/991288.jpg"
          rating: 8.5
          id_: 2993
        }
        ListElement {
          showName: "Loki"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/478/1195717.jpg"
          rating: 8
          id_: 41007
        }
        ListElement {
          showName: "Game of Thrones"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/498/1245274.jpg"
          rating: 8.9
          id_: 82
        }
        ListElement {
          showName: "The Last of Us"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/501/1253495.jpg"
          rating: 8.2
          id_: 46562
        }
        ListElement {
          showName: "House of Dragons"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/509/1274602.jpg"
          rating: 7.7
          id_: 44778
        }
        ListElement {
          showName: "The Boys"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/505/1263296.jpg"
          rating: 8.4
          id_: 15299
        }
      }
      delegate: Rectangle {
        width: 650
        height: 900
        color: "transparent"

        Rectangle {
          Image {
            id: seriesImage

            //sourceSize.height: 600
            //sourceSize.width: seriesImage.sourceSize.width
            sourceSize.width: 650
            sourceSize.height: 650

            source: model.imageUrl
          }

          Text {
            id: trendingShowTitle
            anchors {
              top: seriesImage.bottom
            }

            color: "white"
            text: model.showName
            font.family: webFont.font.family
            font.pixelSize: 40
          }

          Text {
            anchors {
              top: trendingShowTitle.bottom
            }
            color: "#99d98c"
            text: model.rating
            font.family: webFont.font.family
            font.pixelSize: 26
          }
        }
        MouseArea {
          anchors.fill: parent
          onClicked: {
            console.log(showDetailsResult)
            var showUrl = model.id_
            Api.fetchShowDetails(showUrl, function (result) {
              showDetailsResult = result
              console.log(showDetailsResult.image.original)
            })
            openDetails = true
          }
        }
      }
    }
    ShowDetails {
      id: showDetails
      anchors {
        top: searchContainer.bottom
        bottom: parent.bottom
      }
    }
  }
}
