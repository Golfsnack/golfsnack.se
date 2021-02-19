import { Controller } from "stimulus"
export default class extends Controller {
  static targets = ["searchResults", "searchItem"]

  connect() {
    console.log("connected to searchForm controller")
  }

  requestSearch() {
    const resultsArea = document.querySelector(".sys-search-results")
    if (this.searchItemTarget.value.length > 0) {
      resultsArea.classList.add("showing")
      fetch("/golfklubbar/search?query=" + this.searchItemTarget.value)
        .then((response) => {
          return response.text()
        })
        .then((html) => {
          resultsArea.innerHTML = html
        })
    } else {
      resultsArea.classList.remove("showing")
    }
  }
}
