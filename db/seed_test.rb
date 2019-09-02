require 'Nokogiri'

file_path = File.join(__dir__, 'viator.html')
viator_doc = Nokogiri::HTML(File.open(file_path), nil, 'utf-8')
viator_doc.search(".product-card-main-content").each do |element|
  p element.search("pseudo-links product-encoded-url d-block my-2 text-body small")
end

viator_doc.search(".category-card-tag").each do |element|
  p element.text
end
