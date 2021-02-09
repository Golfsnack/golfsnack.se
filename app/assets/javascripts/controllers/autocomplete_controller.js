import { Controller } from "stimulus"
import TomSelect from "https://cdn.skypack.dev/tom-select"

export default class extends Controller {
  static targets = ["field"]

  connect() {
    this.ac = new TomSelect(this.fieldTarget, {
      plugins: ["remove_button"],
      closeAfterSelect: true,
      maxItems: 1,
    })
  }
}
