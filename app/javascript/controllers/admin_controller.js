import { Controller } from "@hotwired/stimulus"
import 'jquery'

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
          // Redirect to a new page after a successful response
          window.location.reload()
        },
        error: function(xhr, status, error) {
          // Handle error cases
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
