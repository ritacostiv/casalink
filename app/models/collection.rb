class Collection < ApplicationRecord
  has_many :properties, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
end
