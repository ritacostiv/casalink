class Event < ApplicationRecord
  after_create_commit -> {
    broadcast_prepend_to "recent_activity", target: "recent-activity-list", partial: "events/event", locals: { event: self }
    broadcast_prepend_to "notifications", target: "notifications-list", partial: "events/notification", locals: { event: self }
  }
  
  belongs_to :user
  belongs_to :property

  enum event_type: {
    property_creation: 0,
    property_update: 1,
    property_deletion: 2,
    comment_creation: 3
  }
end
