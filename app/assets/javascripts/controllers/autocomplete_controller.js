import { Controller } from "stimulus"
import TomSelect from "https://cdn.skypack.dev/tom-select"

class AutocompleteController extends Controller {
  connect() {
    this.ac = new TomSelect(this.fieldTarget, {
      plugins: ["remove_button"],
      create: this.createValue,
      closeAfterSelect: true,
      maxItems: this.createValue ? 5 : 1,
    })
  }
}

AutocompleteController.values = {
  create: Boolean,
}
AutocompleteController.targets = ["field"]

export default AutocompleteController
