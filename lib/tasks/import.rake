#encoding: utf-8 
desc "Refresh all data"

require 'open-uri'
require 'json'
require 'nokogiri'
require 'crack'
require 'csv'

task :import do
	Rake::Task["import_countries"].invoke
	Rake::Task["import_reports"].invoke
	Rake::Task["import_prisoners"].invoke
	Rake::Task["import_prices"].invoke
	Rake::Task["import_dangers"].invoke
	Rake::Task["import_consulates"].invoke
	Rake::Task["import_deaths"].invoke
	Rake::Task["update_weather"].invoke
end

def import_countries(url)
	puts 'IMPORTING COUNTRIES'
	results = JSON.parse(open( url ).read)

	results.each do |result|
		country = Country.find_or_create_by_title( result['location'] );

		puts "Adding / Updating Country #{country.title}"

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

task :import_countries => :environment do
	import_countries('http://opendata.rijksoverheid.nl/v1/sources/rijksoverheid/infotypes/traveladvice?rows=200&offset=0&output=json')
	import_countries('http://opendata.rijksoverheid.nl/v1/sources/rijksoverheid/infotypes/traveladvice?rows=200&offset=200&output=json')

end

task :import_reports => :environment do
	puts "Importing Reports"
	baseUrl = 'http://opendata.rijksoverheid.nl/v1/sources/rijksoverheid/infotypes/traveladvice/'

	countries = Country.all

	countries.each do |country|
		puts "Importing Reports for #{country.title}"

		url = baseUrl + country.openid + '?output=json'
		result = JSON.parse(open( url ).read)

		report = Report.find_or_create_by_country_id(country.id);

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

task :import_prices => :environment do
	puts "Calculating Flight Prices"
	countries = Country.all
	baseUrl = 'http://nl.afstand.org/amsterdam/'
	countries.each do |country|
		puts "Gettign distance to #{country.title}"
		url = URI::encode( baseUrl + country.title )
		doc = Nokogiri::HTML(open(url))
		test = Hash[doc.xpath("//div/@*[starts-with(name(), 'data-')]").map{|e| [e.name,e.value]}]
		price = 50 + ( test['data-distance'].to_i * 0.11 )
		country.price = price
		country.save
	end
end

task :import_prisoners => :environment do
	puts "Importing Prisoners"
	path = 'lib/assets/prisoners.json'
	results = JSON.parse(open( path ).read)
	results.each do |key, value|
		country = Country.find_by_title(key)
		if country
			prisoner = Prisoner.find_or_create_by_country_id( country.id)
			prisoner.count =   value
			prisoner.save
		end
	end
end

task :import_dangers => :environment do
	puts "Checking Dangers"

	categories = ['oorlog', 'rebellen', 'terrorist', 'piraterij', 'geweld', 'carjacking', 'afpersing', 'aardbeving', 'orkaan', 'lawine', 'beroving', 'brand', 'verkeer', 'cycloon', 'demonstratie', 'overstroming', 'wegen']

	categories.each do |category|
		results = Report.where( "reports.algemeen LIKE '%#{category}%' OR reports.actueel LIKE '%#{category}%' OR reports.terrorisme LIKE '%#{category}%' OR reports.criminaliteit LIKE '%#{category}%' OR reports.gebieden LIKE '%#{category}%'" )
		
		results.each do |result|
			country = result.country
			danger = Danger.find_or_create_by_country_id(country.id)
			danger.title = category
			danger.save
		end

	end
end

task :update_weather => :environment do
	puts "Getting Wheater"

	countries = Country.all

	baseUrl = 'http://api.openweathermap.org/data/2.5/weather?q='

	countries.each do |country|
		puts "Getting Wheater for #{country.title}"
		url = URI::encode( baseUrl + country.title )
		json = open( url ).read
		result = json && json.length >= 2 ? JSON.parse(json) : nil
		

		if defined? result['main']['temp']

			temp = result['main']['temp'].to_i - 272.15  

			country.weather_main = result['weather'][0]['main'].to_s
			country.weather_temp = (temp*2).round / 2.0
			country.save

			puts country.title
		end

		sleep(0.5)
	end

end

task :import_consulates => :environment do
	puts "Finding Consulates"
	countryUrl = 'http://www.minbuza.nl/restservice/countries/'

	countries = Hash.from_xml( open( countryUrl ).read )

	countries['channel']['country'].each do |country|
		url = "http://www.minbuza.nl/restservice/countries/#{country['countrycode']}"
		dbCountry = Country.find_by_title(country['title'])

		consulate =  Crack::XML.parse( open( url ).read ) #Hash.from_xml( open( url ).read )

		#next if 
		if dbCountry.title === 'Tadzjikistan' || dbCountry.title === 'Taiwan'
			# puts "NEXT #{dbCountry.title}"
    		next
 		end
 		# puts "TEST #{dbCountry.title}"

		consulate['country']['embassies'].each do |result|
			embassy = result[1]
			if defined? embassy[0]['agencyLocation']
				embassy = embassy[0]
			end

			if defined? embassy['agencyLocation']
				puts "Adding Consulate to #{dbCountry.title}"
				consulate = Consulate.find_or_create_by_title(embassy['agencyLocation'])
			
				consulate.country_id = dbCountry.id
				consulate.location = embassy['coordinates']
				consulate.mail = embassy['email']
				if !embassy['phoneNumbers'].nil?
					if (embassy['phoneNumbers'].values.count === 1 && embassy['phoneNumbers']['phoneNumbers'].first.length > 1)
						consulate.telephone = embassy['phoneNumbers']['phoneNumbers'].first.to_s
					else
						consulate.telephone = embassy['phoneNumbers']['phoneNumbers'].to_s
					end
					puts consulate.telephone
				end
				consulate.fulladdress = embassy['address'].values.join()
				consulate.contact = embassy['agencyHead']

				consulate.save
			end

			
			#raise consulate.to_yaml
		end
	end

end

task :import_deaths => :environment do
	puts "Counting Deaths"
	file = 'lib/assets/deaths.csv'
	contents = File.open(file, 'r:UTF-8') # resolves encoding errors - must use 1.9.3 else use iconv
	CSV.parse( contents , {:col_sep => ',', :quote_char => "|"}) do |row|
		if row[2].nil?
			next
		end

		country = Country.where('title LIKE ?', "%#{row[2].strip[0..4]}%")
		
		if country.first.nil?
			next
		end

		deaths = country.first.deaths.nil? ? 0 : country.first.deaths

		country.first.deaths = deaths + 1

		country.first.save
		puts "#{country.first.deaths} in #{country.first.title}"
	end
end




