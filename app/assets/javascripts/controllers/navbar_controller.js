import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["mobileMenu", "profileMenu", "toggleBtn"]

  toggleProfileMenu() {
    this.profileMenuTarget.classList.toggle("hidden")
  }

  toggleMobileMenu() {
    this.mobileMenuTarget.classList.toggle("hidden")
    this.toggleBtnTarget.classList.toggle("open")
  }
}
