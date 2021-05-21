import { Controller } from "stimulus"

class LightgalleryController extends Controller {
  connect() {
    const thumbs = this.imagesTarget.getElementsByTagName("img")
    if (thumbs && thumbs.length > 0) {
      thumbs[0].classList.add("active-image")
    }
  }

  showImg(event) {
    if (this.hasVideoTarget) {
      this.videoTarget.classList.add("hidden")
    }

    if (this.hasMainimageTarget) {
      this.mainimageTarget.src = event.srcElement.currentSrc
      this.mainimageTarget.classList.remove("hidden")
    } else {
      const mainImage = document.createElement("img")
      mainImage.src = event.srcElement.currentSrc
      mainImage.classList = "object-scale-down w-full h-full"
      mainImage.setAttribute("data-lightgallery-target", "mainimage")
      this.wrapperTarget.appendChild(mainImage)
    }
    this.toggleActiveThumb(event.srcElement)
  }

  showVideo(event) {
    if (this.hasMainimageTarget) {
      this.mainimageTarget.classList.add("hidden")
    }
    this.videoTarget.classList.remove("hidden")
    this.toggleActiveThumb(event.srcElement)
  }

  toggleActiveThumb(srcElement) {
    const images = this.imagesTarget.getElementsByTagName("img")
    for (let img of images) {
      img.classList.remove("active-image")
    }
    srcElement.classList.add("active-image")
  }
}

LightgalleryController.targets = ["mainimage", "images", "wrapper", "video"]

export default LightgalleryController
