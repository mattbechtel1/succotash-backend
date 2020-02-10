require 'json'
require 'rest-client'

class CropsController < ApplicationController

    def create
        pic_url = crop_pic(params[:name])
        byebug
        newCrop = Crop.create(strong_params.merge({pic_url: pic_url}))

        render json: newCrop, except: [:created_at, :updated_at]
    end

    private

    def strong_params
        params.require(:crop).permit(:default_measure, :name, :category)
    end

    def crop_pic(search_term)
        search_url = "https://api.edamam.com/api/food-database/parser?ingr=#{search_term}&app_id=#{Figaro.env.edamam_app_id}&app_key=#{Figaro.env.edamam_app_key}"
        response = JSON.parse(RestClient.get(search_url))

        # iterate through response and return first available image url
        i = 0
        image_url = false
        byebug
        while i < response["hints"].length && !image_url do
            if response["hints"][i]["food"]["image"]
                image_url = response["hints"][i]["food"]["image"]
            end
            i += 1
        end

        image_url
    end
end
