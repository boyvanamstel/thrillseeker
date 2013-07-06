#encoding: utf-8 
desc "Refresh all data"

require 'open-uri'
require 'json'

task :import_countries => :environment do
	url = 'http://opendata.rijksoverheid.nl/v1/sources/rijksoverheid/infotypes/traveladvice?rows=200&offset=0&output=json'	
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

task :import_reports => :environment do
	baseUrl = 'http://opendata.rijksoverheid.nl/v1/sources/rijksoverheid/infotypes/traveladvice/'

	countries = Country.all

	countries.each do |country|
		url = baseUrl + country.openid + '?output=json'
		result = JSON.parse(open( url ).read)

		report = Report.new;

		result['content'].each do |content|
			if content['paragraphtitle'] === 'Actualiteiten'
				report.actueel = content['paragraph']
			elsif content['paragraphtitle'] === 'Algemeen'
				report.algemeen = content['paragraph']
			elsif content['paragraphtitle'] === 'Terrorisme'
				report.terrorisme = content['paragraph']
			elsif content['paragraphtitle'] === 'Zware criminaliteit'
				report.criminaliteit = content['paragraph']
			elsif content['paragraphtitle'] === 'Onveilige gebieden'
				report.gebieden = content['paragraph']
			end
		end

		report.country_id = country.id
		report.save
	end
end

task :import_prisoners => :environment do
	path = 'lib/assets/prisoners.json'
	results = JSON.parse(open( path ).read)
	results.each do |key, value|
		country = Country.find_by_title(key)
		if country
			Prisoner.create( :country_id => country.id, :count =>  value);
		end
	end
end