import { Controller } from "@hotwired/stimulus"
import 'jquery'
import 'toastr'

export default class extends Controller {

  static targets = ['input', 'suggestions']; // Make sure 'suggestions' is included


  clearForm(){
    $("#job_filter :checkbox").prop("checked", false);
    $("#job_filter :input[type='text']").val('');
    $("#job_filter select").val('');
    $(".radius").addClass("hidden")
    $("#search_field").val('')
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
        this.submitForm();
      }
      else if(!$(".radius").hasClass("hidden")){
        if ($("#radius").val() != ''){
          this.submitForm();
        }
      }
    } else if (e.target.value == '' && !$(".radius").hasClass("hidden")) {
      $(".radius").addClass("hidden")
      $("#radius").val(null)
      this.submitForm();
    } else {
      $(".radius").addClass("hidden")
      $("#radius").val(null)
      this.submitForm();
    }
  }


  handleAddressRequest(e) {
    let query = e.target.value;
    clearTimeout(this.searchTimeout);

    // Set a new timeout for 2000 milliseconds (2 seconds)
    this.searchTimeout = setTimeout(() => {
    if (query.length >= 2) {

      $.ajax({
        url: `jobs/search_location?location_query=${query}`,
        method: 'GET',
        dataType: 'json',
        success: (response) => {
          this.displaySuggestions(response.data);
        },
        error: (xhr, status, error) => {
          console.error('Error fetching autocomplete data:', error);
        }
      });
    }else{
      $(".radius").addClass("hidden")
    }}, 500);
  }

  displaySuggestions(data) {
   this.suggestionsTarget.innerHTML = data.map(result => `<li class="" data-coordinates="${result.coordinates}" data-action="click->jobs#selectResult">${result.display_address}</li>`).join('');
    $("#job-suggestions").show()
  }

  selectResult(event) {
    let coordinates = event.target.dataset['coordinates']
    let selectedResult = event.target.textContent;

    $("#address_field").val(coordinates)
    $("#search_field").val(selectedResult)
    $("#job-suggestions").hide()

    if ($(".radius").hasClass("hidden")){
      $(".radius").removeClass("hidden")
      toastr.info("Select the Radius to see the results")
      this.submitForm();
    }
    else if(!$(".radius").hasClass("hidden")){
      if ($("#radius").val() != ''){
        this.submitForm();
      }
    }

    this.suggestionsTarget.innerHTML = '';
  }

  resetUrl(url){
    history.pushState({}, document.title, url);
  }

  showFilter(e){
    e.preventDefault();
    let filterContent = e.target.textContent.replace(/\s+/g, " ").trim()
    if (filterContent == "Show More"){
        $("#speciality").removeClass("h-[230px]")
        $("#speciality").addClass("h-full")
        e.target.textContent = 'Show Less'
    }
    else if (filterContent == "Show Less"){
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
