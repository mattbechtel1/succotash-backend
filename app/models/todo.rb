class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :field, optional: true
  belongs_to :bed, optional: true
end
