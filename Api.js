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
