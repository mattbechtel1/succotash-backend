class FieldsController < ApplicationController
    def index
        fields = Field.all
        render json: FieldSerializer.new(fields).to_serialized_json
    end
    
    def show
        field = Field.find(params[:id])
        render json: FieldSerializer.new(field).to_serialized_json
    end

    def create
        new_field = Field.create(strong_params.merge({slug: slugify(params[:name])}))
        bed_count = new_field.x_axis_count * new_field.y_axis_count
        bed_count.times { |i|
            Bed.create(name: "Bed ##{(i+1).to_s}", field: new_field)
        }
        render json: FieldSerializer.new(new_field).to_serialized_json
    end

    private

    def strong_params
        params.require(:field).permit(:x_axis_count, :y_axis_count, :name)
    end

end
