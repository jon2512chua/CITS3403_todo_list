# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.best_in_place').best_in_place()
  $('.collapse').collapse()
  $.datepicker.setDefaults({ dateFormat: "yy-mm-dd", minDate: "+0d"})
  $("#due_date").datepicker({ dateFormat: "yy-mm-dd" })
