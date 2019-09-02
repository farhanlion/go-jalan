# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'pry'
require 'open-uri'
require 'json'


# Seed four categories
Category.destroy_all
category_array = %w(Restaurants Activities Beauty Fitness)
counter = 0
category_array.each do |category|
  Category.new(name: category_array[counter])
  counter += 1
end

# Destroy all providers
Provider.destroy_all

# Seed restaurants
file_path = File.join(__dir__, 'restaurants.csv')
counter = 1
CSV.foreach(file_path, {:headers => true, :header_converters => :symbol}) do |row|
  new_provider = Provider.new(name: row[:name], description: row[:description], open_hours: row[:hours], price: row[:price], country: 'Singapore')
  new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Restaurants'), provider: new_provider)
  tags = row[:good_for]
  tags.split(" ").each do |tag|
    new_tag = Tag.new(name: tag)
    new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
  end
  # row[:address].match(/(.*)(Singapore.*)/)
  if Provider.find_by(name: row[:name]) == nil
    new_provider.save
  end
  if new_provider.save
    counter += 1
  end
  if counter > 10
    break
  end
end


# # Seed 10 activities
# file_path = File.join(__dir__, 'klook.html')
# klook_doc = Nokogiri::HTML(File.open(file_path), nil, 'utf-8')
# klook_doc.search(".act_card").each do |element|
#   puts title = element.search(".title").text
#   puts price = element.search(".latest_price").text.strip
#   url = element.search("a").map do |element|
#     element.to_h["href"]
#   end
#   match_data = url[0].match(/(.*)\?(.*)$/)
#   p match_data[1]
#   activity_doc = Nokogiri::HTML(open("https://www.klook.com/en-SG/activity/25467-singapore-comic-con-ticket/"), nil, 'utf-8')
#   byebug
#   puts acivity_doc.search(".act_main_section").text.strip
# end
=======
#   movies = Movie.create([{ name: Star Wars }, { name: Lord of the Rings }])
#   Character.create(name: Luke, movie: movies.first)

def new_company(name, translated_name, description, address, phone_number, website)
  company = Provider.new(name: name, translated_name: translated_name, description: description, price: '', avg_rating: '', street_address: address, district: '', city: '', country: '', open_hours: '', phone_number: phone_number, website: website, longitude: '', latitude: '')
  company.save!
end


# BEAUTY COMPANIES

# parse beauty.json
filepath = File.join(__dir__, 'beauty.json')
searialised_beauty_places = File.read(filepath)
beauty_places = JSON.parse(searialised_beauty_places)

#create beauty companies
beauty_places['beauty_companies'].each do |company|
  new_company(company['name'], company['name'], company['description'], company['address'], company['phone'], company['website'])
end


# FITNESS COMPANIES

#parse fitness.json
filepath = File.join(__dir__, 'fitness.json')
searialised_fitness_places = File.read(filepath)
fitness_places = JSON.parse(searialised_fitness_places)

#create fitness companies
fitness_places['fitness_companies'].each do |company|
  new_company(company['name'], company['name'], company['description'], company['address'], company['phone'], company['website'])
end
