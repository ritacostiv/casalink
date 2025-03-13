class Property < ApplicationRecord
  belongs_to :collection
  # after_create :scrape_property_details

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  #private

  # def scrape_property_details
  #   Scraper.new(url).scrape_data
  # end
end
