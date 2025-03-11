class Collection < ApplicationRecord
  has_many :properties
  belongs_to :user
end
