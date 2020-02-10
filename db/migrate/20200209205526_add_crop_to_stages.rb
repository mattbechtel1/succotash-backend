class AddCropToStages < ActiveRecord::Migration[6.0]
  def change
    add_reference :stages, :crop, null: true, foreign_key: true, type: :uuid
  end
end