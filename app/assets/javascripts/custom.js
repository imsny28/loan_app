$(document).ready(function(){
  $('.ui.dropdown') .dropdown();

  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });

  // Per page drop downs
  $(".per_page_select").change(function(){
    $(location).attr('search', 'per_page='+$(this).val());
  });
});
