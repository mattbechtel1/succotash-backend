class Field < ApplicationRecord
    belongs_to :user
    has_many :beds
    has_many :stages, through: :beds
end
