class CreateBeds < ActiveRecord::Migration[6.0]
  def change
    create_table :beds, id: :uuid do |t|
      t.string :name
      t.references :field, null: false, foreign_key: {on_delete: :cascade}, type: :uuid

      t.timestamps
    end
  end
end
