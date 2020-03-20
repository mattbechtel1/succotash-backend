class BedsController < ApplicationController
    def update
        bed = Bed.find(params[:id])
        bed.update(strong_params)
        bed.field.update(updated_at: Time.now)
        render json: BedSerializer.new(bed).to_serialized_json
    end

    private

    def strong_params
        params.require(:bed).permit(:name)
    end
end
