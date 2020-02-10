class AddCategoryToCrops < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE crop_category AS ENUM ('vegetable', 'fruit', 'legume', 'grain', 'flower', 'herb', 'grass', 'other');
    SQL

    add_column :crops, :category, :crop_category
  end

  def down
    remove_column :crops, :category
    execute <<-SQL
      DROP TYPE crop_category;
    SQL
  end
end
