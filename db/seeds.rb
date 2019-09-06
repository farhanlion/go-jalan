require 'csv'
require 'open-uri'
require 'json'
require 'net/http'

Photo.destroy_all
ProviderTag.destroy_all
ProviderCategory.destroy_all
Tag.destroy_all
Category.destroy_all
Review.destroy_all
Provider.destroy_all

category_array = %w[Restaurants Activities Beauty Fitness]
counter = 0
category_array.each do |category|
  new_cat = Category.new(name: category_array[counter])
  counter += 1
  new_cat.save!
end

# Seed restaurants
puts 'Creating restaurants...'
file_path = File.join(__dir__, 'restaurants.csv')
counter = 1
CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
  new_provider = Provider.new(name: row[:name], description: row[:description], open_hours: row[:hours], price: row[:price], country: 'Singapore', street_address: row[:address])
  new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Restaurants'), provider: new_provider)
  new_provider_category.save!

  row[:good_for].split(',').each do |tag|
    new_tag = Tag.new(name: tag.strip)
    if !Tag.all.include?(new_tag)
      new_tag.category = Category.find_by(name: 'Restaurants')
      new_tag.save!
      new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
      new_provider_tag.save!
    else
      new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
      new_provider_tag.save!
    end
  end

  post_code = row[:address].match(/Singapore \((.*)\)/)[1]
  url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
  response = open(url).read
  results = JSON.parse(response)["results"][0]
  if !results.empty?
    street_address = results["ADDRESS"]
    latitude = results["X"]
    longitude = results["LONGITUDE"]
  end

  new_provider.street_address = street_address
  new_provider.latitude = latitude
  new_provider.longitude = longitude

  row[:image].split(" ").first(3).each do |photo_url|
    new_photo = Photo.new(provider: new_provider)
    new_photo.remote_photo_url = photo_url
    new_photo.save!
  end

  new_provider.save if Provider.find_by(name: row[:name]).nil?
  counter += 1 if new_provider.save
  break if counter > 10
end

def viator_image_search(activity_page)
  image_urls = []
  activity_page.search('.embed-responsive img').each do |image|
    next if image.attributes['data-lazy'].nil?

    unless image_urls.include?(image.attributes['data-lazy'].value)
      image_urls << image.attributes['data-lazy'].value
    end
  end
  image_urls
end

def url_should_be_accessible(url)
  success = true
  begin
    Net::HTTP.get_response(URI.parse(url)).is_a?(Net::HTTPSuccess)
  rescue StandardError
    success = false
  end
  success
end

# Seed 10 activitiesHey
puts 'Creating activities...'
file_path = File.join(__dir__, 'viator.html')
counter = 1
viator_doc = Nokogiri::HTML(File.open(file_path), nil, 'utf-8')
viator_doc.search('.product-card-main-content').each do |element|
  name = element.search('h2').text.strip
  price =  element.search('.h4').text.strip.split(' ').first
  activity_url = element.search('a').map do |element|
    element.to_h['href']
  end
  activity_page = Nokogiri::HTML(open(activity_url[0]), nil, 'utf-8')
  description =  activity_page.search('.mb-5 .mb-3').text.strip.match(/Overview(.*)/)[1]
  country = 'Singapore'

  image_urls = viator_image_search(activity_page)

  new_provider = Provider.new(name: name, description: description, price: price, country: country)
  new_provider.save
  new_provider

  image_urls.each do |url|
    new_photo = Photo.new(provider: new_provider)
    if url_should_be_accessible(url)
      new_photo.remote_photo_url = url
      new_photo.save!
    end
  end

  new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Activities'), provider: new_provider)
  new_provider_category.save!

  tag = element.search('.category-card-tag').text
  new_tag = Tag.new(name: tag)
  if !Tag.all.include?(new_tag)
    new_tag.category = Category.find_by(name: 'Restaurants')
    new_tag.save!
    new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
    new_provider_tag.save!
  else
    new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
    new_provider_tag.save!
  end
  counter += 1
  break if counter >= 10
end


# BEAUTY COMPANIES
puts 'Creating beauty companies...'

filepath = File.join(__dir__, 'beauty.json')
serialised_beauty_places = File.read(filepath)
beauty_places = JSON.parse(serialised_beauty_places)

beauty_places['beauty_companies'].each do |company|
  new_provider = Provider.new(name: company['name'], description: company['description'], phone_number: company['phone'], country: 'Singapore')

  post_code = company['address'].match(/\(S\)(\d{6})/)[1]
  url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
  response = open(url).read
  results = JSON.parse(response)["results"][0]
  if !results.empty?
    street_address = results["ADDRESS"]
    latitude = results["LATITUDE"]
    longitude = results["LONGITUDE"]
  end

  new_provider.street_address = street_address
  new_provider.latitude = latitude
  new_provider.longitude = longitude

  # company['image'].each do |pic|
  #   new_photo = Photo.new(provider: new_provider)
  #   new_photo.remote_photo_url = pic
  #   new_photo.save!
  # end

  new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Fitness'), provider: new_provider)
  new_provider_category.save!

  company['tags'].each do |tag|
    new_tag = Tag.new(name: tag)
    if !Tag.all.include?(new_tag)
      new_tag.category = Category.find_by(name: 'Beauty')
      new_tag.save!
      new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
      new_provider_tag.save!
    else
      new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
      new_provider_tag.save!
    end
  end
end


#FITNESS COMPANIES
puts 'Creating fitness companies...'

filepath = File.join(__dir__, 'fitness.json')
serialised_fitness_places = File.read(filepath)
fitness_places = JSON.parse(serialised_fitness_places)

fitness_places['fitness_companies'].each do |company|
  new_provider = Provider.new(name: company['name'], description: company['description'], phone_number: company['phone'], country: 'Singapore')

  post_code = company['address'].match(/\(S\)(\d{6})/)[1]
  url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
  response = open(url).read
  results = JSON.parse(response)["results"][0]
  if !results.empty?
    street_address = results["ADDRESS"]
    latitude = results["LATITUDE"]
    longitude = results["LONGITUDE"]
  end

  new_provider.street_address = street_address
  new_provider.latitude = latitude
  new_provider.longitude = longitude

  company['image'].each do |pic|
    new_photo = Photo.new(provider: new_provider)
    new_photo.remote_photo_url = pic
    new_photo.save!
  end

  new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Fitness'), provider: new_provider)
  new_provider_category.save!

  company['tags'].each do |tag|
    new_tag = Tag.new(name: tag)
    if !Tag.all.include?(new_tag)
      new_tag.category = Category.find_by(name: 'Fitness')
      new_tag.save!
      new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
      new_provider_tag.save!
    else
      new_provider_tag = ProviderTag.new(tag: Tag.find_by(name: tag), provider: new_provider)
      new_provider_tag.save!
    end
  end
end

# seeding new provider favourites
# puts "Creating 10 favourites..."
# 10.times do
#   new_favourite = Favourite.new(user: User.all.sample, provider: Provider.all.sample)
#   new_favourite.save!
# end
