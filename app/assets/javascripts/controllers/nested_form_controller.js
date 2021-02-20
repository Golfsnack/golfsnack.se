import { Controller } from "stimulus"
class NestedFormController extends Controller {
  initialize() {
    this.wrapperSelector = this.wrapperSelectorValue || ".nested-form-wrapper"
  }

  add(e) {
    e.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.targetTarget.insertAdjacentHTML("beforebegin", content)
  }

  remove(e) {
    e.preventDefault()

    const wrapper = e.target.closest(this.wrapperSelector)

    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove()
    } else {
      wrapper.classList.add("toberemoved")
      wrapper.querySelector("input[name*='_destroy']").value = 1
    }
  }
}

NestedFormController.targets = ["target", "template"]
NestedFormController.values = {
  wrapperSelector: String,
}

export default NestedFormController
