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

  puts "#{row[:name]} ... #{row[:address]}"
  post_code = row[:address].match(/Singapore \((.*)\)/)[1] unless row[:address].empty?
  url = "https://developers.onemap.sg/commonapi/search?searchVal=#{post_code}&returnGeom=Y&getAddrDetails=Y&pageNum=1"
  response = open(url).read
  results = JSON.parse(response)["results"][0] unless response.nil?
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
    new_photo.save
  end

  new_provider.save if Provider.find_by(name: row[:name]).nil?
  # counter += 1 if new_provider.save
  # break if counter > 10
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


# Seed users
puts "Creating 5 users..."
persons = []
persons << {
  first_name: 'Edwin',
  last_name: 'Ting',
  email: 'edwintwx@gmail.com',
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
  description: 'I have just graduated from University, learning to code to explore new career opportunities & see where I can go from there.',
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
  new_user = User.new(first_name: person[:first_name], last_name: person[:last_name], email: person[:email], description: person[:description], password: "password")
  new_user.save!
end

