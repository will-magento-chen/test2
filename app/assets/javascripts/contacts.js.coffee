# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.dateonly').datetimepicker({
    format: 'Y-m-d',
    timepicker: false
  })

  $('.timepicker').timepicker({
    template: false,
    showInputs: false,
    minuteStep: 15
  })
