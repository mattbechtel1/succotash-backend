class BedsController < ApplicationController
    def show
        bed = Bed.find(params[:id])
        render json: BedSerializer.new(bed).to_serialized_json
    end

    def update
        bed = Bed.find(params[:id])
        bed.update(strong_params)
        render json: BedSerializer.new(bed).to_serialized_json
    end

    private

    def strong_params
        params.require(:bed).permit(:name)
    end
end
