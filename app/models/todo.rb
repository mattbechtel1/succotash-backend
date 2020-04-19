class Todo < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :field, optional: true, touch: true
  belongs_to :bed, optional: true, touch: true
  validate :bed_requires_field

  def bed_requires_field
    if bed && !field
      errors.add(bed: 'cannot be set without a field')
    end
  end

end
