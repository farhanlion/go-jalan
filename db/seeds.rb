# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'open-uri'
require 'json'
require 'pry'
require 'net/http'

Photo.destroy_all
ProviderTag.destroy_all
ProviderCategory.destroy_all
Tag.destroy_all
Category.destroy_all
Review.destroy_all
Provider.destroy_all

puts "database cleaned"

category_array = %w[Restaurants Activities Beauty Fitness]
counter = 0
category_array.each do |_category|
  new_cat = Category.new(name: category_array[counter])
  p new_cat
  counter += 1
  new_cat.save!
end

# Seed restaurants
puts 'Creating restaurants...'
file_path = File.join(__dir__, 'restaurants.csv')
counter = 1
CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
  new_provider = Provider.new(name: row[:name], description: row[:description], open_hours: row[:hours], price: row[:price], country: 'Singapore')
  new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Restaurants'), provider: new_provider)
  new_provider_category.save!
  row[:good_for].split(' ').each do |tag|
    new_tag = Tag.new(name: tag)
    new_tag.category = Category.find_by(name: 'Restaurants')
    new_tag.save!
    new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
    new_provider_tag.save!
  end
  row[:image].split(' ').each do |photo_url|
    new_photo = Photo.new(provider: new_provider)
    new_photo.remote_photo_url = photo_url
    new_photo.save!
  end
  # row[:address].match(/(.*)(Singapore.*)/)
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
  endcreatcreatee
  success
end

# Seed 10 activities
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
  new_provider.save!

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
  new_tag = Tag.new(name: tag, category: Category.find_by(name: 'Activities'))
  new_tag.save!
  new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
  new_provider_tag.save!
  counter += 1
  break if counter >= 10
end


def new_company(name, translated_name, description, address, phone_number)
  company = Provider.new(name: name, translated_name: translated_name, description: description, price: '', avg_rating: '', street_address: address, district: '', city: '', country: '', open_hours: '', phone_number: phone_number, longitude: '', latitude: '')
  p company
  company.save!
  company
end

# BEAUTY COMPANIES


# parse beauty.json
filepath = File.join(__dir__, 'beauty.json')
searialised_beauty_places = File.read(filepath)
beauty_places = JSON.parse(searialised_beauty_places)

# create beauty companies
beauty_tags = nil
created_company = ''
# create beauty companies
puts 'Creating beauty companies...'
beauty_places['beauty_companies'].each do |company|
  # beauty_tags = company['categories'].gsub('  ', '').split(',')
  created_company = new_company(company['name'], company['name'], company['description'], company['address'], company['phone'])
end
# # create beauty tags
# beauty_tags.uniq!
# beauty_tags.each do |tag|
#   new_tag = Tag.new(name: tag)
#   new_tag.category = Category.find_by(name: 'Beauty')
#   puts new_tag
#   new_tag.save!

#   new_provider_tag = ProviderTag.new(tag: new_tag, provider: created_company)
#   puts new_provider_tag
#   new_provider_tag.save!
# end

# FITNESS COMPANIES


# parse fitness.json
filepath = File.join(__dir__, 'fitness.json')
searialised_fitness_places = File.read(filepath)
fitness_places = JSON.parse(searialised_fitness_places)

# create fitness companies
puts 'Creating fitness companies...'

fitness_tags = []

fitness_places['fitness_companies'].each do |company|
  company['tags'].each do |tag|
    fitness_tags<<tag
  end
  created_company = new_company(company['name'], company['name'], company['description'], company['address'], company['phone'])
  company['image'].each do |pic|
    new_photo = Photo.new(provider: created_company)
    new_photo.remote_photo_url = pic
    p new_photo
    new_photo.save!
  end
end
# create fitness tags
fitness_tags.uniq!
fitness_tags.each do |tag|
  new_tag = Tag.new(name: tag, category: Category.find_by(name: 'Fitness'))
  p new_tag
  new_tag.save!
   
  new_provider_tag = ProviderTag.new(tag: new_tag, provider: created_company)
  p new_provider_tag
  new_provider_tag.save!
end
