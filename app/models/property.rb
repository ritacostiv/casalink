require 'uri'
require 'net/http'

class Property < ApplicationRecord
  belongs_to :collection
  after_create :set_property, :create_property_track_changes
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :nullify
  belongs_to :user
  after_update_commit :update_property_track_changes
  before_destroy :destroy_property_track_changes

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

  private

  def create_property_track_changes
    return unless saved_changes?

    create_event(:property_creation)
  end

  def update_property_track_changes
    return unless saved_changes?

    create_event(:property_update)
  end

  def destroy_property_track_changes
    create_event(:property_deletion)
  end

  def create_event(event_type)
    Event.create(
      property: self,
      user_first_name: user.first_name,
      user_last_name: user.last_name,
      property_name: name,
      url: url,
      collection_name: collection.name,
      collection_url: "/collections/#{collection.id}",
      event_type: event_type
    )
  end
end
