import QtQuick
import QtQuick.Layouts

Rectangle {
  id: trendingsContainer
  visible: !isSearching && !busy && !openDetails
  anchors {
    top: searchContainer.bottom
  }

  color: "black"
  width: parent.width
  height: 40

  FontLoader {
    id: webFont
    source: "https://www.1001fonts.com/download/font/uni-sans.heavy-italic-caps.otf"
  }

  Rectangle {
    id: trendingsTitleContainer
    y: 6
    color: "#08FF5B"
    border.color: "white"
    height: 80
    width: parent.width

    Text {
      id: trendingsTitle
      anchors.centerIn: parent

      text: "Em alta"
      color: "white"
      font.pixelSize: 40
      font.bold: true
    }
  }

  Rectangle {
    x: 10
    y: 100
    color: "transparent"
    height: 700
    width: root.width

    ListView {
      anchors.fill: parent
      orientation: Qt.Horizontal
      spacing: 40
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
          showName: "House of the Dragon"
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
        id: trendingsShowsCards
        color: "#08FF5B"
        border.color: "white"
        border.width: 2

        topRightRadius: 5
        topLeftRadius: 5
        bottomRightRadius: 20
        bottomLeftRadius: 20

        width: 512
        height: 760

        Rectangle {
          x: 6

          Image {
            id: trendingsShowImage
            y: 2
            source: model.imageUrl
            width: 500
            height: 650
          }

          Rectangle {
            x: 4
            anchors {
              top: trendingsShowImage.bottom
              topMargin: 10
            }
            color: "transparent"
            width: 500
            height: 100

            Text {
              id: trendingsShowTitle
              color: "white"
              text: model.showName
              style: Text.Outline
              styleColor: "black"
              font.family: webFont.font.family
              font.pixelSize: 40
            }

            Text {
              anchors {
                top: trendingsShowTitle.bottom
              }
              color: "black"
              text: model.rating + "/10"
              style: Text.Outline
              styleColor: "white"
              font.family: webFont.font.family
              font.pixelSize: 26
            }
          }
        }
        MouseArea {
          anchors.fill: parent
          onClicked: {
            var showUrl = model.id_
            Api.fetchShowDetails(showUrl, function (result) {
              showDetailsResult = result
            })
            openDetails = true
          }
        }
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
