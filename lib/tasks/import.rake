#encoding: utf-8 
desc "Refresh all data"

require 'open-uri'
require 'json'

task :import_countries => :environment do
	url = 'http://opendata.rijksoverheid.nl/v1/sources/rijksoverheid/infotypes/traveladvice?rows=200&offset=200&output=json'	
	results = JSON.parse(open( url ).read)

	results.each do |result|
		country = Country.find_or_create_by_title( result['location'] );
		country.openid = result['id']
		
		classification = 1
		if result['classification'] === 'Waakzaamheid betrachten' || result['classification'] ===  'Extra waakzaamheid betrachten'
			classification = 2
		elsif result['classification'] === 'Niet-essentiële reizen naar bepaalde gebieden worden ontraden' || result['classification'] === 'Niet-essentiële reizen worden ontraden' || result['classification'] === 'Alle reizen naar bepaalde gebieden worden ontraden'
			classification = 3
		elsif result['classification'] === 'Alle reizen worden ontraden'
			classification = 4
		end			
		
		country.classification = classification
		
		country.save
	end

end

task :import_report => :environment do
	baseUrl = 'http://opendata.rijksoverheid.nl/v1/sources/rijksoverheid/infotypes/traveladvice/'

	countries = Country.all

	countries.each do |country|
		url = baseUrl + country.openid + '?output=json'
		result = JSON.parse(open( url ).read)
		puts result.to_yaml
		raise 'end'
	end
end