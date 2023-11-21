import { Controller } from "@hotwired/stimulus"
import 'jquery'
import 'toast'

export default class extends Controller {

  clearForm(){
    $("#job_filter")[0].reset();
    this.submitForm();
  }

  submitForm(e) {
    $("#submitform")[0].click();
  }

  handleRadiusRequest(e){
    if (e.target.value != '' && $(".radius").hasClass("hidden")){
      $(".radius").removeClass("hidden")
      toastr.info("Select the Rdaius to see the results")
    }
    else if (e.target.value == '' && !$(".radius").hasClass("hidden")){
      $(".radius").addClass("hidden")
      $("#radius").val(null)
      this.submitForm();
    }
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

  selectCheckBox(e){
    $('input[type="checkbox"][value="' + e.target.textContent + '"]').prop('checked', true);
  }
}
