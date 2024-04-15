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

  Rectangle {
    id: trendingTitleContainer
    width: parent.width
    height: 100
    color: "#1B263B"
    z: 1

    Text {
      id: trendingTitle
      color: "white"
      anchors.centerIn: parent
      text: "Em alta"
      font.pixelSize: 44
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
          showRating: 8.5
          id_: 526
        }
        ListElement {
          showName: "Breaking Bad"
          imageUrl: "https://static.tvmaze.com/uploads/images/original_untouched/501/1253519.jpg"
          showRating: 9.2
          id_: 169
        }
        ListElement {
          showName: "The Big Bang Theory"
          imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/173/433868.jpg"
          showRating: 8
          id_: 66
        }
        ListElement {
          showName: "The Walking Dead"
          imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/424/1061900.jpg"
          showRating: 8
          id_: 73
        }
        ListElement {
          showName: "Stranger Things"
          imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/396/991288.jpg"
          showRating: 8.5
          id_: 2993
        }
        ListElement {
          showName: "Loki"
          imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/478/1195717.jpg"
          showRating: 8
          id_: 41007
        }
        ListElement {
          showName: "Game of Thrones"
          imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/498/1245274.jpg"
          showRating: 8.9
          id_: 82
        }
        ListElement {
          showName: "The Last of Us"
          imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/501/1253495.jpg"
          showRating: 8.2
          id_: 46562
        }
        ListElement {
          showName: "House of Dragons"
          imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/509/1274602.jpg"
          showRating: 7.7
          id_: 44778
        }
        ListElement {
          showName: "The Boys"
          imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/505/1263296.jpg"
          showRating: 8.4
          id_: 15299
        }
      }
      delegate: Rectangle {
        width: 500
        height: 900
        color: "gray"

        Rectangle {
          Image {
            id: seriesImage

            //sourceSize.width: 900
            //sourceSize.height: 600
            sourceSize.width: seriesImage.sourceSize.width
            sourceSize.height: 650

            source: model.imageUrl
          }

          Text {
            anchors {
              top: seriesImage.bottom
            }
            text: model.showName
            font.pixelSize: 44
          }
        }
        MouseArea {
          anchors.fill: parent
          onClicked: {
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
      title: "Voltar"
      anchors {
        top: searchContainer.bottom
        bottom: parent.bottom
      }
    }
  }
}
