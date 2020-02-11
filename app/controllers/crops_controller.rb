require 'json'
require 'rest-client'

class CropsController < ApplicationController

    def index
        crops = Crop.all.order(name: :asc)
        render json: crops, except: [:created_at, :updated_at]
    end

    def create
        pic_url = crop_pic(params[:name])
        newCrop = Crop.create(strong_params.merge({pic_url: pic_url}))

        render json: newCrop, except: [:created_at, :updated_at]
    end

    private

    def strong_params
        params.require(:crop).permit(:default_measure, :name, :category)
    end

    def crop_pic(search_term)
        search_url = "https://api.spoonacular.com/food/ingredients/autocomplete?query=#{search_term}&apiKey=#{Figaro.env.spoonacular_api_key}"
        response = JSON.parse(RestClient.get(search_url))
        
        img_url = "https://spoonacular.com/cdn/ingredients_100x100/#{response[0]["image"]}"
    end
end
