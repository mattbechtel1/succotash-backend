class CreateStages < ActiveRecord::Migration[6.0]
  def change
    create_table :stages do |t|
      t.integer :cycle_stage
      t.date :start_date
      t.date :due_date
      t.references :bed, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
