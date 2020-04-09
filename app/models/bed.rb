class Bed < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :field, touch: true
  has_many :stages
  has_many :todos
end
