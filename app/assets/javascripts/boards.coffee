# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$("#task-add-sidebar").on("toggled", (event, accordion) ->
  $("#task-add-sidebar").find('dd').each ->
    icon = $(this).find("h4 > i")
    icon.toggleClass("fa-chevron-down",
      $(this).find(".content").hasClass("active"))
)

# HACK TO MAKE THE CALENDAR HEADER APPEAR
$(".calendar table").prepend(
  """
  <thead>
    <tr>
      <td class="text-center">Monday</td>
      <td class="text-center">Tuesday</td>
      <td class="text-center">Wednesday</td>
      <td class="text-center">Thursday</td>
      <td class="text-center">Friday</td>
      <td class="text-center">Saturday</td>
      <td class="text-center">Sunday</td>
    </tr>
  </thead>
  """
)

# date and time pickers
$(->
  $('.date-picker').each(->
    $(this).datepicker()
  )
)
$(->
  $('.time-picker').each(->
    $(this).timepicker({ 'scrollDefault': 'now', 'step': 15 })
  )
)

# toggle competion check fields with checkbox
$(->
  $(".task_completion_check").change(->
    fields = $(this).parent().find(".completion-check-fields-wrapper")
    if (fields.is(':visible'))
      fields.slideUp(200)
    else
      fields.slideDown(200)
  )
)
