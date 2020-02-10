class FavoritesController < ApplicationController

    def create
        favorite = Favorite.create(strong_params)
        # serializer should have crop nested
    end

    def destroy
        Favorite.find(params[:id]).destroy
        render json: { message: 'Favorite removed' } 
    end

    private

    def strong_params
        params.require(:favorite).permit(:user_id, :crop_id)
    end

end
