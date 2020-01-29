# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
def slugify(string)
    string.gsub(/[^0-9a-z ]/i, '').downcase.split(' ').join('-')
end

Stage.destroy_all
Bed.destroy_all
Field.destroy_all



date = Date.today

first_field = Field.create(name: "My first field", x_axis_count: 2, y_axis_count: 2, slug: slugify('My first field'))
second_field = Field.create(name: 'Ye olde field #2@gmail.com', x_axis_count: 4, y_axis_count: 1, slug: slugify('Ye old field #2@gmail.com'))
first_bed = Bed.create(name: "My first bed", field: first_field)
second_bed = Bed.create(name: "My second bed", field: first_field)
first_stage = Stage.create(cycle_stage: :tilled, start_date: '20200128', due_date: (date + 30.days), bed: first_bed)