import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["output", "input"]

  readmultifiles(files) {
    const output = this.outputTarget
    const reader = new FileReader()
    function readFile(index) {
      if (index >= files.length) return
      const file = files[index]
      reader.onload = function (e) {
        const img = document.createElement("img")
        img.src = e.target.result
        img.width = "100"
        img.height = "100"
        img.className = "imgpreview"
        output.append(img)
        // do sth with bin
        readFile(index + 1)
      }
      reader.readAsDataURL(file)
    }
    readFile(0)
  }

  readURL() {
    var input = this.inputTarget
    if (input.files && input.files.length > 0) {
      this.outputTarget.innerHTML = ""
      this.readmultifiles(input.files)
    }
  }
}
