import { Controller } from "@hotwired/stimulus"
import 'jquery'

export default class extends Controller {

  clearForm(){
    $("#job_filter")[0].reset();
    this.submitForm();
  }

  submitForm() {
    $("#submitform")[0].click();
  }
}
