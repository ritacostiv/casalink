# require 'open-uri'
# require 'nokogiri'

# class Scraper
#   def scrape_data(url)
#       # Fetch and parse HTML
#       doc = Nokogiri::HTML(URI.open(url))

#       # Example: Extract title from the webpage
#       property_name = doc.css('.main-info__title-main').text.strip


#       # Save extracted data (customize based on your needs)
#       update(
#         title: title,
#         description: description
#       )
#   end
# end
