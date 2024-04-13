import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Window {
  id: root
  width: 600
  height: 1000
  visible: true

  function fetchShows(query) {
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          var response = JSON.parse(xhr.responseText)
          showListView.model = response.map(function (item) {
            return item
          })
        } else {
          console.error("Erro ao buscar shows:", xhr.status, xhr.statusText)
        }
      }
    }
    xhr.open("GET", "https://api.tvmaze.com/search/shows?q=" + query)
    xhr.send()
  }

  function fetchShowDetails(id) {
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          console.log(xhr.responseText)
          var response = JSON.parse(xhr.responseText)
        } else {
          console.error("Erro ao buscar detalhes do show:", xhr.status,
                        xhr.statusText)
        }
      }
    }
    xhr.open("GET", "https://api.tvmaze.com/shows/" + id)
    xhr.send()
  }

  Rectangle {
    id: title

    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
    }

    height: 80
    color: "blue"

    Text {
      text: "Stone Series"
      anchors.centerIn: parent
      font.pixelSize: 36
      color: "white"
    }
  }

  Rectangle {
    id: main

    anchors {
      top: title.bottom
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }

    color: "green"

    Rectangle {
      id: searchContainer
      color: "red"
      width: parent.width
      height: 40

      anchors {
        left: parent.left
        right: parent.right
        margins: 10
      }

      TextInput {
        id: searchInput

        anchors.fill: parent
        verticalAlignment: TextInput.AlignVCenter

        font.pixelSize: 18
        color: "white"
        leftPadding: 4

        Button {
          text: "Pesquisar"
          anchors.verticalCenter: parent.verticalCenter

          onClicked: {
            fetchShows(searchInput.text)
          }
          anchors {
            right: parent.right
            margins: 10
          }
        }
      }
    }

    Rectangle {
      id: results

      anchors {
        top: searchContainer.bottom
        bottom: parent.bottom
      }

      height: 80
      width: parent.width
      color: "gray"

      ListView {
        id: showListView
        visible: !showDetailsListView
        spacing: 10

        anchors {
          fill: parent
        }

        model: ListModel {
          id: showModel
        }

        delegate: Rectangle {
          width: parent.width
          height: 100
          border.color: "blue"
          color: "transparent"
          Rectangle {
            anchors.fill: parent

            Image {
              id: seriesImage
              sourceSize.width: 300 // Tamanho da imagem
              sourceSize.height: 100 // Tamanho da imagem
              source: modelData.show.image.medium
            }

            Text {
              id: serieTitle
              anchors {
                bottom: parent.verticalCenter
                left: seriesImage.right
                margins: 20
                right: parent.right
              }

              text: modelData.show.name
              font.pixelSize: 22
              font.bold: true
            }
            Text {
              anchors {
                bottom: parent.verticalCenter
                top: serieTitle.bottom
                left: seriesImage.right
                margins: 20
                right: parent.right
              }

              text: modelData.show.rating.average ? "Rating: "
                                                    + modelData.show.rating.average.toString(
                                                      ) : "Sem avaliação"
              font.pixelSize: 16
            }
            MouseArea {
              anchors.fill: parent
              onClicked: {
                var showUrl = modelData.show.id
                fetchShowDetails(showUrl)
              }
            }
          }
        }
      }
    }
  }
}
