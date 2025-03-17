class Event < ApplicationRecord
  belongs_to :user
  belongs_to :property

  enum event_type: {
    property_creation: 0,
    property_update: 1,
    property_deletion: 2,
    comment_creation: 3
  }
end
