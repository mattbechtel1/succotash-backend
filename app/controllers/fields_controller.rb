class FieldsController < ApplicationController

    def index
        fields = Field.all

        render json: FieldSerializer.new(fields).to_serialized_json
    end

    def create
        new_field = Field.create(strong_params)
        
        if new_field.valid?
            new_field = Field.find(new_field.id)
            render json: FieldSerializer.new(new_field).to_serialized_json
        else 
            render json: { error: 'Name invalid. Please try another name for your field.' }, status: :not_acceptable
        end
    end

    def update
        field = Field.find(params[:id])
        result = field.update(strong_params)

        if result
            render json: FieldSerializer.new(field).to_serialized_json
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
        params.require(:field).permit(:x_axis_count, :y_axis_count, :name, :user_id, :pic_opt)
    end

end
