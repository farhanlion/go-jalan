require 'Nokogiri'
require 'pry'
require 'open-uri'


file_path = file_path = File.join(__dir__, 'viator-act.html')
doc = Nokogiri::HTML(File.open(file_path), nil, 'utf-8')
# address
doc.search(".hero-photo-overlay img").each do |image|
  puts image.attributes["src"].value
end
