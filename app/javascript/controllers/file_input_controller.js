import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-input"
export default class extends Controller {
  static targets = ["form", "pickerInput", "label"]

  connect() { }

  dragover() {
    event.preventDefault()
    this.labelTarget.classList.add("dragging")
  }

  dragleave() {
    event.preventDefault()
    this.labelTarget.classList.remove("dragging")
  }

  drop() {
    event.preventDefault()
    this.labelTarget.classList.remove("dragging")

    const files = event.dataTransfer.files
    this.pickerInputTarget.files = files

    this.submit_on_upload()
  }

  submit_on_upload() {
    if (this.pickerInputTarget.files.length > 0) {
      const file = this.pickerInputTarget.files[0]
      const validTypes = ["application/xml", "application/zip", "text/xml"]

      if (validTypes.includes(file.type) || /\.(xml|zip)$/i.test(file.name)) {
        this.formTarget.submit()
      } else {
        // FIXME: change for another alert
        alert("Please select a valid XML or ZIP file.")
      }
    }
  }
}

