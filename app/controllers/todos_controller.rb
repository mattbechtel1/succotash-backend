class TodosController < ApplicationController
    def create
        Todo.create(strong_params)
    end

    private

    def strong_params
        params.require(:todo).permit(:note, :due_date, :start_date, :user_id, :field_id, :bed_id, :complete)
end