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
      new_photo.save
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

  company['image'].each do |pic|
    new_photo = Photo.new(provider: new_provider)
    new_photo.remote_photo_url = pic
    new_photo.save!
  end

  new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Beauty'), provider: new_provider)
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



# Seed reviews
# puts 'Creating 30 reviews...'
video_url_arr = %w(w6q1nsxv2l7axdeuxd51 little-damage_iyvk0q sugar-cane-tower_lc78so jiggly-cheesecake_uykdbl pearl-hotpot2_z3pohc cheese-ball_d0424y souffle-pancake_p8ixxc dumplings_qrzpmf jajanan_qbm8xw cheese-toast_czn6vb big-bowl-ramen_gjhu4q)
# video_url_arr.each do |url|
#   new_review_photo = ReviewPhoto.new(photo_url: photo_url)
# end


# # # Seed new favs
# puts 'Creating 10 favs for the first user...'
# counter = 1
# 10.times do
#   new_favourite = Favourite.new(user: User.first, provider: Provider.find(counter))
#   new_favourite.save!
#   counter += 1
# end

# # Seed new likes
# # puts "Creating 10 likes for the first user..."
# counter = 1
# 10.times do
#   new_like = Like.new(user: User.first, review: Review.find(counter))
#   new_like.save!
#   counter += 1
# end

