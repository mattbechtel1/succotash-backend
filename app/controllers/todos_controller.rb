class TodosController < ApplicationController
    def create
        todo = Todo.create(strong_params)
        if todo.valid?
            render json: TodoSerializer.new(todo).to_serialized_json
        else
            render json: { error: 'Cannot associate a new task with a bed but not a field.' }, status: :not_acceptable
        end
            
    end

    def show
        todo = Todo.find(params[:id])
        render json: TodoSerializer.new(todo).to_serialized_json
    end

    def update
        todo = Todo.find(params[:id])
        result = todo.update(strong_params)

        if result
            render json: TodoSerializer.new(todo).to_serialized_json
        else 
            render json: { error: 'Could not update your task.'}
        end
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