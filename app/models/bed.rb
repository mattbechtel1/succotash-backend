class Bed < ApplicationRecord
  belongs_to :field
  has_many :stages
end
