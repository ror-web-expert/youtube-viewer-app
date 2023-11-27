import { Controller } from "@hotwired/stimulus"
import 'jquery'
import 'toastr'

export default class extends Controller {

  clearForm(){
    $("#job_filter :checkbox").prop("checked", false);
    $("#job_filter :input[type='text']").val('');
    $("#job_filter select").val('');
    $(".radius").addClass("hidden")
    this.submitForm();
  }

  submitForm() {
    this.updateUrl()
    $("#submitform")[0].click();

  }

  handleRadiusRequest(e){
    if (e.target.value != ''){
      if ($(".radius").hasClass("hidden")){
        $(".radius").removeClass("hidden")
        toastr.info("Select the Radius to see the results")
      }
      else if(!$(".radius").hasClass("hidden")){
        this.submitForm();
      }
    }
    else if (e.target.value == '' && !$(".radius").hasClass("hidden")){
      $(".radius").addClass("hidden")
      $("#radius").val(null)
      this.submitForm();
    }
  }

  resetUrl(url){
    history.pushState({}, document.title, url);
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

  updateUrl(source){
    var formData = $("#job_filter").serializeArray().filter(function(item) {
      return item.value !== "" && item.value !== null;
    });
    if(formData.length > 0){
      var currentUrl = window.location.origin + "?" + this.formatUrl(formData);
      this.resetUrl(currentUrl)
    }
    else{
      this.resetUrl(window.location.origin)
    }
  }

  formatUrl(formData){
    let formattedParams = {}
    $.each(formData, function(index, value) {
      var key = value.name.replace(/\[\]/g, '')
      var val = value.value
        if (formattedParams.hasOwnProperty(key)) {
          formattedParams[key].push(val)
        }
        else if(value.name.includes("[]")){
          formattedParams[key] = [val]
        }
        else {
          formattedParams[key] = val
        }
    });
    return $.param(formattedParams);
  }
}
