class RemoveStartDateFromTodos < ActiveRecord::Migration[6.0]
  def change
    remove_column :todos, :start_date
  end
end
