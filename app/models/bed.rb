class Bed < ApplicationRecord
  default_scope { order(created_at: :asc) }

  after_create :initiate_stages

  belongs_to :field, touch: true
  has_many :stages
  has_many :todos

  def initiate_stages
    Stage.create(bed: self, start_date: Date.new(2015, 1, 1), due_date: Date.today - 1)
    Stage.create(bed: self, start_date: Date.today)
  end

end
