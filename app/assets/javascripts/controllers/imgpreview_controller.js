import { Controller } from "stimulus"
class ImgPreview extends Controller {
  readmultifiles(files) {
    const output = this.outputTarget
    const reader = new FileReader()
    function readFile(index) {
      if (index >= files.length) return
      const file = files[index]
      reader.onload = function (e) {
        const img = document.createElement("img")
        img.src = e.target.result
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

ImgPreview.targets = ["output", "input"]

export default ImgPreview
