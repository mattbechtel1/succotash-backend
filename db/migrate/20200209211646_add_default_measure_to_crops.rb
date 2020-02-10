class AddDefaultMeasureToCrops < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE unit AS ENUM ('bushel', 'count', 'bunch', 'peck', 'pounds', 'crate', 'dry quart');
    SQL

    add_column :crops, :default_measure, :unit
  end

  def down
    remove_column :crops, :default_measure
    execute <<-SQL
      DROP TYPE unit;
    SQL
  end
end
