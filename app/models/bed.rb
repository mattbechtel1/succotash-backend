class Bed < ApplicationRecord
  belongs_to :field
  has_many :stages
  has_many :todos
end
