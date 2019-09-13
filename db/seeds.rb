require 'csv'
require 'open-uri'
require 'json'
require 'net/http'

# Photo.destroy_all
# ProviderTag.destroy_all
# ProviderCategory.destroy_all
# Tag.destroy_all
# Category.destroy_all
# Review.destroy_all
# Provider.destroy_all
# User.destroy_all


# category_array = %w[Restaurants Activities Beauty Fitness]
# category_array.each do |category|
#   new_cat = Category.new(name: category)
#   new_cat.save!
# end

# BEAUTY COMPANIES
# puts 'Creating beauty companies...'

# filepath = File.join(__dir__, 'beauty.json')
# serialised_beauty_places = File.read(filepath)
# beauty_places = JSON.parse(serialised_beauty_places)

# beauty_places['beauty_companies'].each do |company|
# puts Provider.count

#   new_provider = Provider.new(name: company['name'], description: company['description'], phone_number: company['phone'], country: 'Singapore')
# puts new_provider.name

#   post_code = company['address'].match(/(\d{6})/)
#   if post_code != nil
#   url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
#   response = open(url).read
#   results = JSON.parse(response)["results"][0]
#   if !results.empty?
#     street_address = results["ADDRESS"]
#     latitude = results["LATITUDE"]
#     longitude = results["LONGITUDE"]
#   end

#   new_provider.street_address = street_address
#   new_provider.latitude = latitude
#   new_provider.longitude = longitude

#   company['image'].each do |pic|
#     new_photo = Photo.new(provider: new_provider)
#     new_photo.remote_photo_url = pic
#     new_photo.save!

#   end

#   new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Beauty'), provider: new_provider)
#   new_provider_category.save!

#   company['tags'].each do |tag|
#     new_tag = Tag.new(name: tag)
#     if !Tag.all.include?(new_tag)
#       new_tag.category = Category.find_by(name: 'Beauty')
#       new_tag.save!
#       new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
#       new_provider_tag.save!
#     else
#       new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
#       new_provider_tag.save!
#     end
#   end
# end
# end



#FITNESS COMPANIES
# frozen_string_literal: true

# puts 'Creating fitness companies...'

# filepath = File.join(__dir__, 'fitness.json')
# serialised_fitness_places = File.read(filepath)
# byebug
# fitness_places = JSON.parse(serialised_fitness_places)

# fitness_places['fitness_companies'].each do |company|
#   puts Provider.count
#   new_provider = Provider.new(name: company['name'], description: company['description'], phone_number: company['phone'], country: 'Singapore')
#   puts new_provider.name
#   post_code = company['address'].match(/(\d{6})/)
#   next if post_code.nil?

#   url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
#   response = open(url).read
#   results = JSON.parse(response)['results'][0]
#   unless results.empty?
#     street_address = results['ADDRESS']
#     latitude = results['LATITUDE']
#     longitude = results['LONGITUDE']
#   end


#     new_provider = Provider.new(name: name, description: description, price: price, country: country, latitude: 1.3521, longitude: 103.8198)
#     if Provider.find_by(name: name).nil?
#         new_provider.save!
#         image_urls.each do |url|
#           new_photo = Photo.new(provider: new_provider)
#           if url_should_be_accessible(url)
#             new_photo.remote_photo_url = url
#             new_photo.save!
#           end
#         end

#         new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Activities'), provider: new_provider)
#         new_provider_category.save!

#         tag = element.search('.category-card-tag').text
#         new_tag = Tag.new(name: tag)
#         if !Tag.all.include?(new_tag)
#           new_tag.category = Category.find_by(name: 'Restaurants')
#           new_tag.save!
#           new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
#           new_provider_tag.save!
#         else
#           new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
#           new_provider_tag.save!
#         end
#       end
#     end
# end


# page_counter = 1

# 5.times do
#   file_path = File.join(__dir__, "viator#{page_counter}.html")
#   scrape_viator(file_path)
#   page_counter += 1
# end


# # Seed restaurants
# puts 'Creating restaurants...'
# file_path = File.join(__dir__, 'restaurants.csv')
# counter = 1
# CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
#   new_provider = Provider.new(name: row[:name], description: row[:description], open_hours: row[:hours], price: row[:price], country: 'Singapore', street_address: row[:address])
#   new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Restaurants'), provider: new_provider)
#   new_provider_category.save!

#   row[:good_for].split(',').each do |tag|
#     new_tag = Tag.new(name: tag.strip)
#     if !Tag.all.include?(new_tag)
#       new_tag.category = Category.find_by(name: 'Restaurants')
#       new_tag.save!
#       new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
#       new_provider_tag.save!
#     else
#       new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
#       new_provider_tag.save!
#     end
#   end

#   post_code = row[:address].match(/Singapore \((.*)\)/)[1]
#   url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
#   response = open(url).read
#   results = JSON.parse(response)["results"][0]
#   if !results.empty?
#     street_address = results["ADDRESS"]
#     latitude = results["X"]
#     longitude = results["LONGITUDE"]
#   end

#   new_provider.street_address = street_address
#   new_provider.latitude = latitude
#   new_provider.longitude = longitude

#   row[:image].split(" ").first(3).each do |photo_url|
#     new_photo = Photo.new(provider: new_provider)
#     new_photo.remote_photo_url = photo_url
#     new_photo.save!
#   end

#   new_provider.save if Provider.find_by(name: row[:name]).nil?
#   counter += 1 if new_provider.save
#   break if counter > 10
# end

# def viator_image_search(activity_page)
#   image_urls = []
#   activity_page.search('.embed-responsive img').each do |image|
#     next if image.attributes['data-lazy'].nil?

#     unless image_urls.include?(image.attributes['data-lazy'].value)
#       image_urls << image.attributes['data-lazy'].value
#     end
#   end
#   image_urls
# end

# def url_should_be_accessible(url)
#   success = true
#   begin
#     Net::HTTP.get_response(URI.parse(url)).is_a?(Net::HTTPSuccess)
#   rescue StandardError
#     success = false
#   end
#   success
# end


# BEAUTY COMPANIES
# puts 'Creating beauty companies...'

# filepath = File.join(__dir__, 'beauty.json')
# serialised_beauty_places = File.read(filepath)
# beauty_places = JSON.parse(serialised_beauty_places)

# beauty_places['beauty_companies'].each do |company|
# puts Provider.count
# byebug if Provider.count==109

#   new_provider = Provider.new(name: company['name'], description: company['description'], phone_number: company['phone'], country: 'Singapore')
# puts new_provider.name

#   post_code = company['address'].match(/(\d{6})/)
#   if post_code != nil
#   url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
#   response = open(url).read
#   results = JSON.parse(response)["results"][0]
#   if !results.empty?
#     street_address = results["ADDRESS"]
#     latitude = results["LATITUDE"]
#     longitude = results["LONGITUDE"]
#   end


#   new_provider.street_address = street_address
#   new_provider.latitude = latitude
#   new_provider.longitude = longitude

#   company['image'].each do |pic|
#     new_photo = Photo.new(provider: new_provider)
#     new_photo.remote_photo_url = pic
#     new_photo.save!

#     p new_photo
#   end

#   new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Fitness'), provider: new_provider)


#   end

#   new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Beauty'), provider: new_provider)

#   new_provider_category.save!

#   company['tags'].each do |tag|
#     new_tag = Tag.new(name: tag)
#     if !Tag.all.include?(new_tag)



#       new_tag.category = Category.find_by(name: 'Beauty')
#       new_tag.save!
#       new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
#       new_provider_tag.save!
#       p new_provider_tag
#     else
#       new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
#       new_provider_tag.save!
#       p new_provider_tag
#     end
#     new_provider.save!
#   end
# end
# end




# # Seed activities
# puts 'Creating activities...'

# def viator_image_search(activity_page)
#   image_urls = []
#   activity_page.search('.embed-responsive img').each do |image|
#     next if image.attributes['data-lazy'].nil?

#     unless image_urls.include?(image.attributes['data-lazy'].value)
#       image_urls << image.attributes['data-lazy'].value
#     end
#   end
#   image_urls
# end

# def url_should_be_accessible(url)
#   success = true
#   begin
#     Net::HTTP.get_response(URI.parse(url)).is_a?(Net::HTTPSuccess)
#   rescue StandardError
#     success = false
#   end
#   success
# end

# def scrape_viator(file_path)
#   viator_doc = Nokogiri::HTML(File.open(file_path), nil, 'utf-8')
#   viator_doc.search('.product-card-main-content').each do |element|
#     name = element.search('h2').text.strip
#     price =  element.search('.h4').text.strip.split(' ').first
#     activity_url = element.search('a').map do |element|
#       element.to_h['href']
#     end
#     activity_page = Nokogiri::HTML(open(activity_url[0]), nil, 'utf-8')
#     description =  activity_page.search('.mb-5 .mb-3').text.strip.match(/Overview(.*)/)[1]
#     country = 'Singapore'

#     image_urls = viator_image_search(activity_page)

#     new_provider = Provider.new(name: name, description: description, price: price, country: country, latitude: 1.3521, longitude: 103.8198)
#     new_provider.save!
#     puts new_provider.name

#     image_urls.each do |url|
#       new_photo = Photo.new(provider: new_provider)
#       if url_should_be_accessible(url)
#         new_photo.remote_photo_url = url
#         new_photo.save!
#       end
#     end

#     new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Activities'), provider: new_provider)
#     new_provider_category.save!

#     tag = element.search('.category-card-tag').text
#     new_tag = Tag.new(name: tag)
#     if !Tag.all.include?(new_tag)
#       new_tag.category = Category.find_by(name: 'Restaurants')
#       new_tag.save!
#       new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
#       new_provider_tag.save!
#     else
#       new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
#       new_provider_tag.save!
#     end
#   end
# end


# page_counter = 1

# 5.times do
#   file_path = File.join(__dir__, "viator#{page_counter}.html")
#   scrape_viator(file_path)
#   page_counter += 1
# end

#FITNESS COMPANIES
# frozen_string_literal: true

# puts 'Creating fitness companies...'

# filepath = File.join(__dir__, 'fitness.json')
# serialised_fitness_places = File.read(filepath)
# byebug
# fitness_places = JSON.parse(serialised_fitness_places)

# fitness_places['fitness_companies'].each do |company|
#   puts Provider.count
#   new_provider = Provider.new(name: company['name'], description: company['description'], phone_number: company['phone'], country: 'Singapore')
#   puts new_provider.name
#   post_code = company['address'].match(/(\d{6})/)
#   next if post_code.nil?

#   url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
#   response = open(url).read
#   results = JSON.parse(response)['results'][0]
#   unless results.empty?
#     street_address = results['ADDRESS']
#     latitude = results['LATITUDE']
#     longitude = results['LONGITUDE']
#   end
#   new_provider.street_address = street_address
#   new_provider.latitude = latitude
#   new_provider.longitude = longitude

#   company['image'].each do |pic|
#     new_photo = Photo.new(provider: new_provider)
#     new_photo.remote_photo_url = pic
#     new_photo.save!
#     p new_photo
#   end

#   new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Fitness'), provider: new_provider)
#   new_provider_category.save!

#   company['tags'].each do |tag|
#     new_tag = Tag.new(name: tag)
#     if !Tag.all.include?(new_tag)
#       new_tag.category = Category.find_by(name: 'Fitness')
#       new_tag.save!
#       new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
#       new_provider_tag.save!
#       p new_provider_tag
#     else
#       new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
#       new_provider_tag.save!
#       p new_provider_tag
#     end
#     new_provider.save!
#   end
# end




# # Seed restaurants
# puts 'Creating restaurants...'
# file_path = File.join(__dir__, 'restaurants.csv')
# counter = 1
# CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
#   new_provider = Provider.new(name: row[:name], description: row[:description], open_hours: row[:hours], price: row[:price], country: 'Singapore', street_address: row[:address])
#   new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Restaurants'), provider: new_provider)
#   new_provider_category.save!

#   row[:good_for].split(',').each do |tag|
#     new_tag = Tag.new(name: tag.strip)
#     if !Tag.all.include?(new_tag)
#       new_tag.category = Category.find_by(name: 'Restaurants')
#       new_tag.save!
#       new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
#       new_provider_tag.save!
#     else
#       new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
#       new_provider_tag.save!
#     end
#   end

#   post_code = row[:address].match(/Singapore \((.*)\)/)[1]
#   url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
#   response = open(url).read
#   results = JSON.parse(response)["results"][0]
#   if !results.empty?
#     street_address = results["ADDRESS"]
#     latitude = results["X"]
#     longitude = results["LONGITUDE"]
#   end

#   new_provider.street_address = street_address
#   new_provider.latitude = latitude
#   new_provider.longitude = longitude

#   row[:image].split(" ").first(3).each do |photo_url|
#     new_photo = Photo.new(provider: new_provider)
#     new_photo.remote_photo_url = photo_url
#     new_photo.save!
#   end

#   new_provider.save if Provider.find_by(name: row[:name]).nil?
#   counter += 1 if new_provider.save
#   break if counter > 10
# end


puts 'Editing restaurants'
file_path = File.join(__dir__, 'restaurants.csv')
CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
  if !Provider.find_by(name: row[:name]).nil?
    provider = Provider.find_by(name: row[:name])
    post_code = row[:address].match(/Singapore \((.*)\)/)[1]
    url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
    response = open(url).read
    results = JSON.parse(response)["results"][0]
    if !results.empty?
      street_address = results["ADDRESS"]
      latitude = results["LATITUDE"]
      longitude = results["LONGITUDE"]
    end
    provider.street_address = street_address
    provider.latitude = latitude
    provider.longitude = longitude

    provider.save!
    puts "#{provider.name}: #{provider.latitude} & #{provider.longitude}"
  end
end


# # Seed users
# puts "Creating 5 users..."
# persons = []
# persons << {
#   first_name: 'Edwin',
#   last_name: 'Ting',
#   email: 'edwintwx@gmail.com',
#   description: 'Digital Marketing Professional across China and Singapore, who loves technology and wants to build products that can change people\'s life.'
# }

# persons << {
#   first_name: 'Grace',
#   last_name: 'Cheung',
#   email: 'grace.cheung@example.com',
#   description: 'I was studying Chemical Engineering in University. Upon chancing a basic coding module in my course, it got me really interested in coding',
# }

# persons << {
#   first_name: 'Claire',
#   last_name: 'Wong',
#   email: 'claire_wong427@gmail.com',
#   description: 'I have just graduated from University, learning to code to explore new career opportunities & see where I can go from there.',
# }

# persons << {
#   first_name: 'Terence',
#   last_name: 'Hung',
#   email: 'terence_hung@example.com',
#   description: 'Hello! I\'m Terence, founder and video director at Ted Media. I\'m learning to code so I can launch new businesses that can make a positive impact.'
# }

# persons << {
#   first_name: 'Meixuan',
#   last_name: 'Oh',
#   email: "meixuanong@yahoo.com",
#   description: 'Initially, I was working as a technical presales. First at IBM Storage and then for Dropbox Business under Ingram Micro.'
# }

# persons.each do |person|
#   new_user = User.new(first_name: person[:first_name], last_name: person[:last_name], email: person[:email], description: person[:description], password: "password")
#   new_user.save!
# end

