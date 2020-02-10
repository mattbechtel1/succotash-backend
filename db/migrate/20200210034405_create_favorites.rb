class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade}, type: :uuid
      t.references :crop, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
