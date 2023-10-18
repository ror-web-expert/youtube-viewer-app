import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"
Rails.start();

export default class extends Controller {

  submitForm() {
    Rails.fire(document.getElementById("job_filter"), "submit");
  }
}
