require 'uri'
require 'net/http'

class Property < ApplicationRecord
  belongs_to :collection
  after_create :set_property

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def extract_property_id
    match = url.match(/(\d+)\/$/)
    match[1] if match
  end

  def set_property
    property_id = extract_property_id
    url = URI("https://idealista7.p.rapidapi.com/propertydetails?propertyId=#{property_id}&location=pt&language=en")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = '88810938d8mshbd2ca5d8f05300bp17eaf3jsn0dfb38524df4'
    request["x-rapidapi-host"] = 'idealista7.p.rapidapi.com'

    response = http.request(request)
    doc = JSON.parse(response.read_body)
    update(
      price: doc["price"],
      name: doc["suggestedTexts"]["title"],
      #size: "#{doc["constructedArea"]} m²",
      size: doc["moreCharacteristics"]["constructedArea"],
      typology: doc["moreCharacteristics"]["roomNumber"],
      address: doc["ubication"]["title"],
      elevator: doc["moreCharacteristics"]["lift"],
      garage: doc["moreCharacteristics"]["garage"],
    )
  end
end
