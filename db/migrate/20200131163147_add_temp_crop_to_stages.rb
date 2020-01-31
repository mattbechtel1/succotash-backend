class AddTempCropToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :tempCrop, :string
  end
end
