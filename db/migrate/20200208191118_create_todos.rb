class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :note
      t.datetime :due_date
      t.datetime :start_date
      t.boolean :complete
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :field, null: true, foreign_key: true, type: :uuid
      t.references :bed, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
