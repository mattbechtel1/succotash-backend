class FieldsController < ApplicationController
    def show
        field = Field.find(params[:id])
        render json: FieldSerializer.new(field).to_serialized_json
    end

    def create
        new_field = Field.create(strong_params.merge({slug: slugify(params[:name])}))

        if new_field.valid?
            bed_count = new_field.x_axis_count * new_field.y_axis_count
            bed_count.times { |i|
                bed = Bed.create(name: "Bed ##{(i+1).to_s}", field: new_field)
                Stage.create(status: :unused, start_date: Date.new(2015, 1, 1), due_date: Date.today - 1,
                    bed: bed, crop: nil)
                Stage.create(status: :unused, start_date: Date.today, bed: bed, crop: nil)
            }
            render json: FieldSerializer.new(new_field).to_serialized_json
        else 
            render json: { error: 'Name invalid. Please try another name for your field.' }, status: :not_acceptable
        end
    end
    
    def destroy
        Field.find(params[:id]).destroy

        render json: { message: 'Deletion successful' }
    end

    private

    def strong_params
        params.require(:field).permit(:x_axis_count, :y_axis_count, :name, :user_id)
    end

end
