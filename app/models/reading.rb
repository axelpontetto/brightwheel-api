class Reading < ApplicationRecord
  belongs_to :device
  validates :timestamp, :count, presence: true
end
