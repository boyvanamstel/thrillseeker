# Introduction

This is the entry for the Hackathon organized by the Dutch Ministry of Foreign Affairs.

It focuses on exploiting the current information available to serve a new target audience: adventurous vacationers. And adding an e-commerce component.

# Running the demo

* Clone;
* Run ```bundle install```;
* Run ```rake db:migrate```;
* Run ```rake import``` to include all the datasets;
* Start the rails server: ```rails s```.

# Included datasets

* [Dutch Foreign Affairs Travel Advice](http://opendata.rijksoverheid.nl/v1/sources/rijksoverheid/infotypes/traveladvice);
* [Death of U.S. Citizens Abroad by Non-Natural Causes](http://travel.state.gov/law/family_issues/death/death_600.html);
* [Dutch Prisoners Abroad](http://www.prisonlaw.nl/nl/landen);
* [Weather](api.openweathermap.org);
* [Flight Prices](http://blog.rome2rio.com/2013/01/02/170779446/);
* [Dutch Consulates](http://www.minbuza.nl/restservice/countries/).

# Credits

* Barry Borsboom [@barryborsboom](http://twitter.com/barryborsboom)
* Robin Aldenhoven [@raldenhoven](http://twitter.com/raldehoven)
* Boy van Amstel [@boyvanamstel](http://twitter.com/boyvanamstel)