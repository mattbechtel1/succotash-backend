class AddSlugToFields < ActiveRecord::Migration[6.0]
  def change
    add_column :fields, :slug, :string
  end
end
