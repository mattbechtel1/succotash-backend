class Field < ApplicationRecord
    belongs_to :user, touch: true
    has_many :beds
    has_many :stages, through: :beds
    has_many :todos
    validates :slug, uniqueness: { scope: :user_id, message: "Field name already in use. Please select a different name or delete the existing field."}
    validate :name_not_new
    
    def name_not_new
        if slug == 'new'
            errors.add(:name, "cannot be 'new'.")
        end
    end

end
