class Bed < ApplicationRecord
  belongs_to :field, touch: true
  has_many :stages
  has_many :todos
end
