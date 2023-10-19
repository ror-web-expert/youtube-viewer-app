import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

  submitForm() {
    document.getElementById("submitform").click();
    // Rails.fire(document.getElementById("job_filter"), "submit");

  }
}
