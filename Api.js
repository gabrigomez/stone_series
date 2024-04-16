function fetchShows(query) {
  return new Promise((resolve, reject) => {
    busy = true
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          var response = JSON.parse(xhr.responseText)
          if (response.length === 0) {
            noResults = true
          }
          resolve(response)
          showListView.model = response.map(function (item) {
            return item
          })
        } else {
            reject(new Error("Erro ao buscar shows: " + xhr.status + " - " + xhr.statusText))
          }
        busy = false
      }
    }
  xhr.open("GET", "https://api.tvmaze.com/search/shows?q=" + query)
  xhr.send()
 })
}


function fetchShowDetails(id, callback) {
  return new Promise((resolve, reject) => {
    busy = true
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          var response = JSON.parse(xhr.responseText)
          callback(response)
        } else {
            reject(new Error("Erro ao buscar detalhes do show: " + xhr.status + " - " + xhr.statusText))
          }
        busy = false
      }
    }
   xhr.open("GET", "https://api.tvmaze.com/shows/" + id)
   xhr.send()
  })
}
