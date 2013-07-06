json.array!(@countries) do |country|
  json.extract! country, :id, :openid, :title, :classification
  json.url country_url(country, format: :json)
end
