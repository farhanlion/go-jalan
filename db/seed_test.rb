require 'Nokogiri'
require 'pry'
require 'open-uri'
require 'csv'

filepath = File.join(__dir__, 'fitness.json')
serialised_fitness_places = File.read(filepath)
fitness_places = JSON.parse(serialised_fitness_places)

fitness_places['fitness_companies'].each do |company|
  p company['address']
  p post_code = company['address'].match(/\(S\)(\d{6})/)[1]
  url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
  response = open(url).read
  results = JSON.parse(response)["results"][0]
  if !results.empty?
    p street_address = results["ADDRESS"]
    p latitude = results["LATITUDE"]
    p longitude = results["LONGITUDE"]
  end
end

# file_path = File.join(__dir__, 'viator.html')
# viator_doc = Nokogiri::HTML(File.open(file_path), nil, 'utf-8')
# viator_doc.search(".product-card-main-content").each do |element|
#   activity_url = element.search("a").map do |element|
#     element.to_h["href"]
#   end
#   activity_page = Nokogiri::HTML(open(activity_url[0]), nil, 'utf-8')
#    element = activity_page.search(".collapse .show")
#    element.each do |e|
#     p e
#     end
#   break
# end

# counter = 1
# file_path = File.join(__dir__, 'restaurants.csv')
# CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|

#   post_code = row[:address].match(/Singapore \((.*)\)/)[1]
#   url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
#   response = open(url).read
#   results = JSON.parse(response)["results"][0]
#   if !results.empty?
#     standardised_street_address = results["ADDRESS"]
#     lat = results["LATITUDE"]
#     lng = results["LONGITUDE"]
#     p lat
#     p lng
# #   end



#   counter += 1
#   break if counter >= 10
# end
