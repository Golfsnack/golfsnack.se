import { Controller } from "stimulus"
import TomSelect from "https://cdn.skypack.dev/tom-select"

export default class extends Controller {
  static values = {
    create: Boolean,
  }
  static targets = ["field"]

  connect() {
    this.ac = new TomSelect(this.fieldTarget, {
      plugins: ["remove_button"],
      create: this.createValue,
      closeAfterSelect: true,
      maxItems: this.createValue ? 5 : 1,
    })
  }
}
