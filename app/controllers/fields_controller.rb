class FieldsController < ApplicationController
    def show
        field = Field.all[0]
        render json: FieldSerializer.new(field).to_serialized_json
    end

end
