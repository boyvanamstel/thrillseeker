# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(->

  $('#countries li.country').each( (i, country) ->
    $.ajax({
      type : "GET",
      dataType : "jsonp",
      url : 'http://api.openweathermap.org/data/2.5/weather?q=' + $('h2', country).text() 
      success: (data) ->
        if data.main && data.main.temp
          $('.temp', country).text( (Math.round((data.main.temp - 272.15) * 10) / 10) + '°C' )
    });
  )

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
    $('#countries li.classification_' + value).slideDown()
  )

  $('#slider-element').change()
  $('#slider-element').mouseup()

)
