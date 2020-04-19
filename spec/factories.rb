
FactoryBot.define do

    cat_options = [:vegetable, :fruit, :legume, :grain, :flower, :grass, :herb, :other]
    measure_options = [:bushel, :ind_count, :bunch, :peck, :pounds, :crate, :dry_quart]
    dumb_user = User.new(username: 'Bob')

    factory :crop, class: Crop do
        name {[Faker::Food.unique.fruits, Faker::Food.unique.vegetables].sample}
        category {cat_options.sample}
        default_measure {measure_options.sample}
    end
end