// set time out alert
setTimeout(function() {
  $('.alert').fadeOut('slow');
}, 3000);
// show file name on file field
$(document).ready(function() {
  $(".custom-file-input").on("change", function() {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
  });
});
// auto submit form limit items
$(document).ready(function() {
  $("#show-limit").on("change", function(){
    $(this).closest("form").trigger("submit");
  });
});
