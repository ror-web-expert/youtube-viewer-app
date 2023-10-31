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

  resetUrl(){
    var baseUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
    history.pushState({}, document.title, baseUrl);
  }

  showFilter(e){
    e.preventDefault();
    if (e.target.textContent == "Show More"){
        $("#speciality").removeClass("h-[230px]")
        $("#speciality").addClass("h-full")
        e.target.textContent = 'Show Less'
    }
    else if (e.target.textContent == "Show Less"){
      $("#speciality").removeClass("h-full")
      $("#speciality").addClass("h-[230px]")
      e.target.textContent = 'Show More'
    }
  }
}
