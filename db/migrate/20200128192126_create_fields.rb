class CreateFields < ActiveRecord::Migration[6.0]
  def change
    create_table :fields, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.integer :x_axis_count
      t.integer :y_axis_count
      t.string :name

      t.timestamps
    end
  end
end
