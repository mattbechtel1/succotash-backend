# assign seed_basic_data to true to completely reset the database with seeds, set to false to clear db completely on reset/seed
seed_basic_data = false


def slugify(string)
    string.gsub(/[^0-9a-z ]/i, '').downcase.split(' ').join('-')
end

User.destroy_all

if seed_basic_data
    date = Date.new(2015, 1, 2)

    userA = User.create(username: 'farmerMatt', password: 'password')
    
    first_field = Field.create(name: "My first field", x_axis_count: 2, y_axis_count: 2, user: userA, slug: slugify('My first field'))

    first_bed = Bed.create(name: "My first bed", field: first_field)
        Stage.create(status: :harvest, start_date: date, bed: first_bed, tempCrop: 'carrots')

    second_bed = Bed.create(name: "My second bed", field: first_field)
        Stage.create(status: :growth, start_date: date, bed: second_bed, tempCrop: 'rhubarb')

    third_bed = Bed.create(name: 'My third bed', field: first_field)
        Stage.create(status: :planted, start_date: date, bed: third_bed, tempCrop: 'cucumbers')

    fourth_bed = Bed.create(name: 'My fourth bed', field: first_field)
        Stage.create(status: "planted", start_date: date, due_date: (date + 30.days), bed: fourth_bed, tempCrop: nil)
        Stage.create(status: :tilled, start_date: Date.today, bed: fourth_bed, tempCrop: 'soybeans')


    second_field = Field.create(name: 'Ye olde field #2@gmail.com', user: userA, x_axis_count: 1, y_axis_count: 1, slug: slugify('Ye old field #2@gmail.com'))
    lonely_bed = Bed.create(name: 'Lonely bed', field: second_field)
    first_stage = Stage.create(status: :tilled, start_date: '20200128', due_date: (date + 30.days), bed: lonely_bed, tempCrop: nil)
end