persons = []
persons << {
  first_name: 'Edwin',
  last_name: 'Ting',
  email: 'edwin_ting@gmail.com',
  description: 'Digital Marketing Professional across China and Singapore, who loves technology and wants to build products that can change people\'s life.'
}

persons << {
  first_name: 'Grace',
  last_name: 'Cheung',
  email: 'grace.cheung@example.com',
  description: 'I was studying Chemical Engineering in University. Upon chancing a basic coding module in my course, it got me really interested in coding',
}

persons << {
  first_name: 'Claire',
  last_name: 'Wong',
  email: 'claire_wong427@gmail.com',
  description: 'I have just graduated from University, learning to code to explore new career opportunities & see where I can go from there.'
}

persons << {
  first_name: 'Terence',
  last_name: 'Hung',
  email: 'terence_hung@example.com',
  description: 'Hello! I\'m Terence, founder and video director at Ted Media. I\'m learning to code so I can launch new businesses that can make a positive impact.'
}

persons << {
  first_name: 'Meixuan',
  last_name: 'Oh',
  email: "meixuanong@yahoo.com",
  description: 'Initially, I was working as a technical presales. First at IBM Storage and then for Dropbox Business under Ingram Micro.'
}


persons.each do |person|
  User.new(first_name: person[:first_name], last_name: person[:last_name], email: person[:email], description: person[:description], password: "password" )
end


# filepath = File.join(__dir__, 'fitness.json')
# serialised_fitness_places = File.read(filepath)
# fitness_places = JSON.parse(serialised_fitness_places)

# fitness_places['fitness_companies'].each do |company|
#   p company['address']
#   p post_code = company['address'].match(/\(S\)(\d{6})/)[1]
#   url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
#   response = open(url).read
#   results = JSON.parse(response)["results"][0]
#   if !results.empty?
#     p street_address = results["ADDRESS"]
#     p latitude = results["LATITUDE"]
#     p longitude = results["LONGITUDE"]
#   end
# end

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
