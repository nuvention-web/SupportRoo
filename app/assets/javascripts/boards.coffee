# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$("#task-add-sidebar").on("toggled", (event, accordion) ->
  $("#task-add-sidebar").find('dd').each ->
    if $(this).find(".content").hasClass("active")
      $(this).find("h4 > i").removeClass("fa-chevron-right")
      $(this).find("h4 > i").addClass("fa-chevron-down")
)
