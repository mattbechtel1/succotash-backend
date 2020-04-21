class Field < ApplicationRecord
    attribute :pic_opt, :string, default: "soil"
    attribute :x_axis_count, :integer, default: 1
    attribute :y_axis_count, :integer, default: 1
    belongs_to :user, touch: true
    has_many :beds
    has_many :stages, through: :beds
    has_many :todos
    before_validation :assign_slug
    validates :slug, uniqueness: { scope: :user_id, message: "Field name already in use. Please select a different name or delete the existing field."}
    validate :name_not_new
    after_create :populate_beds
    
    def name_not_new
        if slug == 'new'
            errors.add(:name, "cannot be 'new'.")
        elsif slug.length < 1
            errors.add(:name, 'must contain at least one alphanumeric character')
        end
    end

    def populate_beds
        total = self.y_axis_count * self.x_axis_count

        total.times {|num| Bed.create(field: self, name: "Bed ##{(num+1).to_s}") }
    end

    private

    def assign_slug
        self.slug = slugify(self.name)
    end
end