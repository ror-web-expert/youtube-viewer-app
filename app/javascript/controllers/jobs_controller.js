import { Controller } from "@hotwired/stimulus"
import 'jquery'

export default class extends Controller {

  submitForm() {
    $("#submitform")[0].click();
  }

  clearForm(){
    $("#job_filter")[0].reset();
    $("#submitform")[0].click();
  }
}
