class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :text, presence: true
end
