class Device < ApplicationRecord
  has_many :readings
  validates :uuid, presence: true, uniqueness: true
end
