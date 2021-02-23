import { Controller } from "stimulus"

class LightgalleryController extends Controller {
  connect() {
    console.log("connected")
    console.log(this.mainimageTarget)
  }
  showImg(event) {
    this.mainimageTarget.src = event.srcElement.currentSrc
    const images = this.imagesTarget.getElementsByTagName("img")
    for (let img of images) {
      img.classList.remove("active-image")
    }
    event.srcElement.classList.add("active-image")
  }
}

LightgalleryController.targets = ["mainimage", "images"]

export default LightgalleryController
