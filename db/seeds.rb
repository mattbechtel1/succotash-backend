# assign seed_basic_data to true to completely reset the database with seeds, set to false to clear db completely on reset/seed
seed_basic_data = true

def slugify(string)
    string.gsub(/[^0-9a-z ]/i, '').downcase.split(' ').join('-')
end

def crop_pic(search_term)
    search_url = "https://api.spoonacular.com/food/ingredients/autocomplete?query=#{search_term}&apiKey=#{Figaro.env.spoonacular_api_key}"
    response = JSON.parse(RestClient.get(search_url))

    if response[0]
        img_url = "https://spoonacular.com/cdn/ingredients_100x100/#{response[0]["image"]}"
    else
        img_url = nil
    end
    img_url
end

User.destroy_all
Crop.destroy_all

if seed_basic_data
    date = Date.new(2020, 1, 3)

    userA = User.create(username: 'farmerMatt', password: 'password')

    Crop.create(name: 'Sweet corn', default_measure: :bushel, category: :grain, pic_url: 'https://cdn.pixabay.com/photo/2012/02/22/19/42/cereal-15528_960_720.jpg')
    Crop.create(name: 'Cotton', default_measure: :pounds, category: :flower, pic_url: 'https://upload.wikimedia.org/wikipedia/commons/6/68/CottonPlant.JPG')
    Crop.create(name: 'Apples', default_measure: :bushel, category: :fruit, pic_url: crop_pic('Apple'))
    Crop.create(name: 'Almonds', default_measure: :pounds, category: :fruit, pic_url: crop_pic('Almond'))
    Crop.create(name: 'Short-grain rice', default_measure: :pounds, category: :grain, pic_url: crop_pic('rice'))
    Crop.create(name: 'Soybeans', default_measure: :bushel, category: :legume, pic_url: 'https://upload.wikimedia.org/wikipedia/commons/8/82/Soybean.USDA.jpg')
    Crop.create(name: 'Rhubarb', default_measure: :bunch, category: :herb, pic_url: crop_pic('rhubarb'))
    Crop.create(name: 'Turnips', default_measure: :bushel, category: :vegetable, pic_url: crop_pic('turnips'))
   
    # carrots = Crop.create(name: 'Carrots', default_measure: :bushel, category: :vegetable)
    # rhubarb = Crop.create(name: 'Rhubarb', default_measure: :bunch, category: :herb)
    # cucumbers = Crop.create(name: 'Cucubmber', default_measure: :bushel, category: :vegetable)
    # soybeans = Crop.create(name: 'Soybeans', default_measure: :bushel, category: :legume)
    
    # first_field = Field.create(name: "My first field", x_axis_count: 3, y_axis_count: 3, user: userA, slug: slugify('My first field'))

    # first_bed = Bed.create(name: "My first bed", field: first_field)
    #     Stage.create(status: :harvest, start_date: date, bed: first_bed, crop: nil)

    # second_bed = Bed.create(name: "My second bed", field: first_field)
    #     Stage.create(status: :growing, start_date: date, bed: second_bed, crop: nil)

    # third_bed = Bed.create(name: 'My third bed', field: first_field)
    #     Stage.create(status: :planted, start_date: date, bed: third_bed, crop: nil)

    # fourth_bed = Bed.create(name: 'My fourth bed', field: first_field)
    #     Stage.create(status: "planted", start_date: date, due_date: (date + 30.days), bed: fourth_bed, crop: nil)
    #     Stage.create(status: :tilled, start_date: Date.today, bed: fourth_bed, crop: nil)

    #     Todo.create(note: 'Milk cows', due_date: Date.today + 1.days, complete: false, user: userA)

    #     Todo.create(note: 'Buy seeds', due_date: (date + 3.days), complete: false, user: userA, bed: fourth_bed, field: fourth_bed.field)
    #     Todo.create(note: 'Scatter seeds', due_date: (date + 5.days), complete: false, user: userA, bed: fourth_bed, field: fourth_bed.field)


    # second_field = Field.create(name: 'Ye olde field #3@gmail.com', user: userA, x_axis_count: 1, y_axis_count: 1, slug: slugify('Ye old field #3@gmail.com'))
    # lonely_bed = Bed.create(name: 'Lonely bed', field: second_field)
    # first_stage = Stage.create(status: :tilled, start_date: '20200128', due_date: (date + 30.days), bed: lonely_bed, crop: nil)
end