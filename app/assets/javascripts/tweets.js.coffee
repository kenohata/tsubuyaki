$ ->
  $(".tweet .content").click ->
    $(this).parents(".tweet").children(".accordion-body").collapse('toggle')