class FavoritesController < ApplicationController

    def create
        favorite = Favorite.create(strong_params)

        render json: FavoriteSerializer.new(favorite).to_serialized_json
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
