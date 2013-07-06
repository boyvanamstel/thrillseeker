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
        $('.temp', country).text(data.main.temp)
        console.log data
    });
  )

  $('#slider-element').change(->
    $('#slider-value').html(this.value)
    $('#countries li.country').hide();
    $('#countries li.classification_' + this.value).slideDown()
  )

  $('#slider-element').change()

)
