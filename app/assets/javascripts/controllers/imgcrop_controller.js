import { Controller } from "stimulus"
import fizzerCroppie from "https://cdn.skypack.dev/@fizzer/croppie"
const debounce = (func, wait, immediate) => {
  var timeout
  return function () {
    var context = this,
      args = arguments
    var later = function () {
      timeout = null
      if (!immediate) func.apply(context, args)
    }
    var callNow = immediate && !timeout
    clearTimeout(timeout)
    timeout = setTimeout(later, wait)
    if (callNow) func.apply(context, args)
  }
}
export default class extends Controller {
  static targets = ["output", "input", "preview", "field", "submit"]
  static values = { width: Number, height: Number }

  connect() {
    const output = this.outputTarget
    const preview = this.previewTarget
    if (preview && preview.src) {
      const img = document.createElement("img")
      img.className = "imgpreview"
      img.src = preview.src
      output.append(img)
      this.initCroppie(img, true)
    }
  }

  initCroppie(img, setBoundary) {
    const submit = this.submitTarget
    const preview = this.previewTarget
    const field = this.fieldTarget
    const width = this.widthValue
    const height = this.heightValue

    const options = { viewport: { width, height, type: "square" } }
    if (setBoundary) {
      options.boundary = { width, height }
    }

    const croppie = new fizzerCroppie(img, options)
    croppie.element.addEventListener(
      "update",
      debounce(function () {
        croppie.result("base64").then((base64) => {
          preview.src = base64
          field.value = base64
          submit.disabled = false
        })
      }, 100),
    )
  }

  readmultifiles(files) {
    const output = this.outputTarget
    const reader = new FileReader()

    const readFile = (index) => {
      if (index >= files.length) return
      const file = files[index]
      reader.onload = (e) => {
        const img = document.createElement("img")
        img.src = e.target.result
        img.className = "imgpreview"
        output.append(img)

        this.initCroppie(img)

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
