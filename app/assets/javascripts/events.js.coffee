# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#create-contact").on "show.bs.modal", ->
    $("#new_contact")[0].reset()
  $("#new_contact").on("ajax:success", (e, data, status, xhr) ->
    $("#event_host_id").append("<option selected value='#{data.id}'>#{data.first_name} #{data.last_name}</option>")
    $("#create-contact").modal('hide')
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#create-contact .alert").removeClass "hide"
    $("#create-contact .alert .content").html("")
    xhr.responseJSON.contacts.forEach (e) ->
      $("#create-contact .alert .content").append "<p>#{e}</p>"
    return
