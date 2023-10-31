import { Controller } from "@hotwired/stimulus"
import 'jquery'
import 'toast'

export default class extends Controller {
  

  handleState(e){
    if (e.target.checked) {
      $('.post-checkbox:visible').prop('checked', true);
      $("#statuses").toggle("h-0 overflow-hidden")
    } else {
      $('.post-checkbox:visible').prop('checked', false);
    $("#statuses").toggle("h-0 overflow-hidden")
    }
  }

  handleUpdateStatus(e){
    if ($(".post-checkbox:visible:checked").length < 1){
      alert('Please select a Job to change its Status');
    }
    else {
      var selectedPostIds = [];

      $('.post-checkbox:checked').each(function() {
        selectedPostIds.push($(this).val());
      });

      var payload = {
        status: $("#status").val(),
        post_ids: selectedPostIds
      }
      $.ajax({
        url: e.target.dataset.url,
        method: 'PATCH',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        success: function(response) {
          $('input[type="checkbox"]:visible:checked').prop('checked', false);
          toastr.success("Status of all Posts has been changed successfully")
          setTimeout(function() {
            location.reload();
          }, 2000);
        },
        error: function(xhr, status, error) {
          toastr.error("Something went Wrong. Please try again.")
        }
      });
      
    }
  }

  handleSelect(e){
    if ($(".post-checkbox:visible:checked").length > 0 && !$("#statuses").is(":visible")){
      $("#statuses").toggle("h-0 overflow-hidden")
    }
    else if ($(".post-checkbox:visible:checked").length < 1 && $("#statuses").is(":visible")){
      $("#statuses").toggle("h-0 overflow-hidden")
    }
  }
}
