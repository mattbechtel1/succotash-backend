
FactoryBot.define do

    cat_options = [:vegetable, :fruit, :legume, :grain, :flower, :grass, :herb, :other]
    measure_options = [:bushel, :ind_count, :bunch, :peck, :pounds, :crate, :dry_quart]
    
    # factory :user, class User do
    #     username 'Bob'
    #     password 'pickles'
    # end

    factory :crop, class: Crop do
        name {[Faker::Food.fruits, Faker::Food.vegetables].sample}
        category {cat_options.sample}
        default_measure {measure_options.sample}
    end
end