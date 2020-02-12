class AddPicChoiceToFields < ActiveRecord::Migration[6.0]
  def change
    add_column :fields, :pic, :string
  end
end
