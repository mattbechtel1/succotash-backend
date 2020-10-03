class Crop < ApplicationRecord
    attribute :favorite_count
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
    validates :name, uniqueness: { case_sensitive: false }
    after_create :set_pic

    def set_pic
        self.update_attribute(:pic_url, find_pic(self.name))
    end

    def favorite_count
        Favorite.where(crop_id: self.id).count
    end

    private

    def find_pic(search_term)
        return nil unless ENV["spoonacular_api_key"]
        search_url = "https://api.spoonacular.com/food/ingredients/autocomplete?query=#{search_term}&apiKey=#{ENV["spoonacular_api_key"]}"
        response = JSON.parse(RestClient.get(search_url))
        
        if response[0]
            img_url = "https://spoonacular.com/cdn/ingredients_100x100/#{response[0]["image"]}"
        else
            img_url = nil
        end
        img_url
    end
end