class CreateStages < ActiveRecord::Migration[6.0]
  def up 

    create_table :stages do |t|
      t.date :start_date
      t.date :due_date
      t.references :bed, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end


  def down
    drop_table :stages
  end
end
