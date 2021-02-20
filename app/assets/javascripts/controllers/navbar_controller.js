import { Controller } from "stimulus"
class NavbarController extends Controller {
  toggleProfileMenu() {
    this.profileMenuTarget.classList.toggle("hidden")
  }

  toggleMobileMenu() {
    this.mobileMenuTarget.classList.toggle("hidden")
    this.toggleBtnTarget.classList.toggle("open")
  }
}

NavbarController.targets = ["mobileMenu", "profileMenu", "toggleBtn"]

export default NavbarController
