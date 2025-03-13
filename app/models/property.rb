class Property < ApplicationRecord
  belongs_to :collection
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # after_create :scrape_property_details

  # private


  #private

  # def scrape_property_details
  #   Scraper.new(url).scrape_data
  # end
end
