class Favorite < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :crop
end
