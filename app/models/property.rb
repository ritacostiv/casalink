class Property < ApplicationRecord
  belongs_to :collection

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # after_create :scrape_property_details

  # private


  #1. add method to call the API
end
