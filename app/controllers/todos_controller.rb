class TodosController < ApplicationController
    def create
        todo = Todo.create(strong_params)
        render json: todo, only: [:id, :note, :due_date, :start_date, :complete, :user_id, :field_id, :bed_id]
    end

    def show
        todo = Todo.find(params[:id])
        render json: todo, only: [:id, :note, :due_date, :start_date, :complete, :user_id, :field_id, :bed_id]
    end

    def destroy
        
    end

    private

    def strong_params
        params.require(:todo).permit(:note, :due_date, :start_date, :user_id, :field_id, :bed_id, :complete)
    end
end