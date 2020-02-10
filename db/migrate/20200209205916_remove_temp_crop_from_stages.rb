class RemoveTempCropFromStages < ActiveRecord::Migration[6.0]
  def change
    remove_column :stages, :tempCrop
  end
end
