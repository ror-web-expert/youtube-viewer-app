import { Controller } from "@hotwired/stimulus"
import 'jquery'

export default class extends Controller {

  submitForm() {
    document.getElementById("submitform").click();
  }

  clearForm(){
    $("#job_filter")[0].reset();
    document.getElementById("submitform").click();
  }
}
