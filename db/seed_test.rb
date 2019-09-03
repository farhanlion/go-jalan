require 'Nokogiri'
require 'pry'
require 'open-uri'

# Seed 10 activities
file_path = File.join(__dir__, 'viator.html')
viator_doc = Nokogiri::HTML(File.open(file_path), nil, 'utf-8')
viator_doc.search(".product-card-main-content").each do |element|
  name = element.search("h2").text.strip
  price =  element.search(".h4").text.strip.split(" ").first
  url = element.search("a").map do |element|
    element.to_h["href"]
  end
  activity_doc = Nokogiri::HTML(open(url[0]), nil, 'utf-8')
  match_data =  activity_doc.search(".mb-5 .mb-3").text.strip.match(/Overview(.*)/)
  description = match_data[1]
  country = 'Singapore'
  # address
  match_data = activity_doc.search(".mr-md-4").text.match(/^(.*Singapore)/)
  street_address = match_data[1]

  new_provider = Provider.new(name: name)
  new_provider.save!
  new_provider_category = ProviderCategory.new(category: Category.find_by(name: 'Activities'), provider: new_provider)
  new_provider_category.save!

  new_service = Service.new(name: name, description: description, street_address: street_address, country: country, provider: new_provider)
  binding.pry
  tag =  element.search(".category-card-tag").text
  new_tag = Tag.new(name: tag, category: Category.find_by(name: 'Activities'))
  new_tag.save!

  new_provider_tag = ProviderTag.new(tag: new_tag, provider: new_provider)
  new_provider.save!
  new_service.save!
end

