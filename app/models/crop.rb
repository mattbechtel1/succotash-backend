class Crop < ApplicationRecord
    has_many :stages
    has_many :favorites
    enum category: {
        vegetable: 'vegetable',
        fruit: 'fruit',
        legume: 'legume',
        grain: 'grain',
        flower: 'flower',
        grass: 'grass',
        herb: 'herb',
        other: 'other'
    }
    enum default_measure: {
        bushel: 'bushel',
        ind_count: 'count',
        bunch: 'bunch',
        peck: 'peck',
        pounds: 'pounds',
        crate: 'crate',
        dry_quart: 'dry quart'
    }
end