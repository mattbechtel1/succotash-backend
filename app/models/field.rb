class Field < ApplicationRecord
    has_many :beds
    has_many :stages, through: :beds
end
