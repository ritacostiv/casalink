class Property < ApplicationRecord
  belongs_to :collection
  after_create :scrape_property_details

  private

  def scrape_property_details
    Scraper.new(url).scrape_data
  end
end
