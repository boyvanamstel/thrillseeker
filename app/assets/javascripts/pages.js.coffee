# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(->

  slider_images = ["rustgevend", "actief", "spannend", "extreem"]

  prev_value = 1
  value = 1

  $('#slider-element').change(->
    value = Math.round(this.value)
    if value != prev_value
      $('.slider-image').hide()
      slider_image = slider_images[value - 1]
      $('#slider-image-' + slider_image).show()
      prev_value = value
  )

  $('#slider-element').mouseup(->
    $('#slider-element').val(value)
    $('#countries li.country').hide();
    $('#countries li.classification_' + value).show()
  )

  $('#slider-element').on('touchend',->
    $('#slider-element').trigger('mouseup')
  )

  
  $('#slider-element').trigger('mouseup')

)
