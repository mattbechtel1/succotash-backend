# assign seed_basic_data to true to completely reset the database with seeds, set to false to clear db completely on reset/seed
seed_basic_data = true

User.destroy_all
Crop.destroy_all

if seed_basic_data
    date = Date.new(2020, 1, 3)

    userA = User.create(username: 'farmerMatt', password: 'password')

    Crop.create(name: 'Sweet corn', default_measure: :bushel, category: :grain)
    Crop.create(name: 'Cotton', default_measure: :pounds, category: :flower)
    Crop.create(name: 'Apples', default_measure: :bushel, category: :fruit)
    Crop.create(name: 'Almonds', default_measure: :pounds, category: :fruit)
    Crop.create(name: 'Short-grain rice', default_measure: :pounds, category: :grain)
    Crop.create(name: 'Soybeans', default_measure: :bushel, category: :legume)
    rhubarb = Crop.create(name: 'Rhubarb', default_measure: :bunch, category: :herb)
    Crop.create(name: 'Turnips', default_measure: :bushel, category: :vegetable)
   
    carrots = Crop.create(name: 'Carrots', default_measure: :bushel, category: :vegetable)
    cucumbers = Crop.create(name: 'Cucubmber', default_measure: :bushel, category: :vegetable)
    soybeans = Crop.create(name: 'Soybeans', default_measure: :bushel, category: :legume)
    
    first_field = Field.create(name: "My first field", x_axis_count: 3, y_axis_count: 3, user: userA)

        Todo.create(note: 'Milk cows', due_date: Date.today + 1.days, complete: false, user: userA)

        Todo.create(note: 'Buy seeds', due_date: (date + 3.days), complete: false, user: userA, bed: first_field.beds[3], field: first_field)
        Todo.create(note: 'Scatter seeds', due_date: (date + 5.days), complete: false, user: userA, bed: first_field.beds[3], field: first_field)


    second_field = Field.create(name: 'Ye olde field #3@gmail.com', user: userA, x_axis_count: 1, y_axis_count: 1)
end