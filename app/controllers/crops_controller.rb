class CropsController < ApplicationController

    def index
        crops = Crop.all.order(name: :asc)
        render json: crops
    end

    def create
        newCrop = Crop.create(strong_params)
        
        if newCrop.valid?
            render json: newCrop, except: [:created_at, :updated_at]
        else
            render json: { error: 'This crop is already on our list.' }, status: :not_acceptable
        end
    end

    private

    def strong_params
        params.require(:crop).permit(:default_measure, :name, :category)
    end
end
