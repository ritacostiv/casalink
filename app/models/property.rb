require 'uri'
require 'net/http'

class Property < ApplicationRecord
  belongs_to :collection
  after_create :set_property
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :nullify
  belongs_to :user

  # not needed because lat and long are already provided by the API
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

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
    request["x-rapidapi-key"] = ENV.fetch("RAPIDAPI_KEY")
    request["x-rapidapi-host"] = 'idealista7.p.rapidapi.com'

    response = http.request(request)
    doc = JSON.parse(response.read_body)
    update(
      price: doc["price"],
      name: doc["suggestedTexts"]["title"],
      size: doc["moreCharacteristics"]["constructedArea"],
      typology: doc["moreCharacteristics"]["roomNumber"],
      address: doc["ubication"]["title"],
      elevator: doc["moreCharacteristics"]["lift"],
      garage: doc["moreCharacteristics"]["garage"],
      image1: doc["multimedia"]["images"][0]["url"],
      image2: doc["multimedia"]["images"][1]["url"],
      image3: doc["multimedia"]["images"][2]["url"],
      image4: doc["multimedia"]["images"][3]["url"],
      latitude: doc["ubication"]["latitude"],
      longitude: doc["ubication"]["longitude"]
    )
  end
end
