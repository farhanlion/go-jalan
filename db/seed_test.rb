require 'Nokogiri'
require 'pry'
require 'open-uri'


file_path = File.join(__dir__, 'viator.html')
viator_doc = Nokogiri::HTML(File.open(file_path), nil, 'utf-8')
viator_doc.search(".product-card-main-content").each do |element|
  activity_url = element.search("a").map do |element|
    element.to_h["href"]
  end
  activity_page = Nokogiri::HTML(open(activity_url[0]), nil, 'utf-8')
  p activity_page.search(".collapse .show")
  break
end
