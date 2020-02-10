class CreateCrops < ActiveRecord::Migration[6.0]
  def change
    create_table :crops, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name
      t.string :pic_url

      t.timestamps
    end
  end
end
