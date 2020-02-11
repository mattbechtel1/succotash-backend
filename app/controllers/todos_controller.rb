class TodosController < ApplicationController
    def create
        todo = Todo.create(strong_params)
        if todo.valid?
            render json: todo, only: [:id, :note, :due_date, :start_date, :complete, :user_id, :field_id, :bed_id]
        else
            render json: { error: 'Cannot associate a new task with a bed but not a field.' }, status: :not_acceptable
        end
            
    end

    def show
        todo = Todo.find(params[:id])
        render json: todo, only: [:id, :note, :due_date, :start_date, :complete, :user_id, :field_id, :bed_id]
    end

    def update
        todo = Todo.find(params[:id])
        todo.update(strong_params)
        render json: todo, only: [:id, :note, :due_date, :start_date, :complete, :user_id, :field_id, :bed_id]
    end

    def destroy
        Todo.find(params[:id]).destroy
        render json: { message: 'Todo removed' } 
    end

    private

    def strong_params
        params.require(:todo).permit(:note, :due_date, :start_date, :user_id, :field_id, :bed_id, :complete)
    end
end