# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: Star Wars }, { name: Lord of the Rings }])
#   Character.create(name: Luke, movie: movies.first)
require 'json'

Provider.destroy_all


def new_company(name, translated_name, description, address, phone_number, website)
  company = Provider.new(name: name, translated_name: translated_name, description: description, price: '', avg_rating: '', street_address: address, district: '', city: '', country: '', open_hours: '', phone_number: phone_number, website: website, longitude: '', latitude: '')
  company.save!
end


# BEAUTY COMPANIES

#parse beauty.json
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
