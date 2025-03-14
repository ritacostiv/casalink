class Property < ApplicationRecord
  belongs_to :collection

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  #1. add method to call the API
end
