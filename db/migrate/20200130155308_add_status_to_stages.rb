class AddStatusToStages < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE cycle_stage AS ENUM ('unused', 'tilled', 'planted', 'growing', 'harvest', 'barren');
    SQL

    add_column :stages, :status, :cycle_stage
  end

  def down
    remove_column :stages, :status
    execute <<-SQL
      DROP TYPE cycle_stage;
    SQL
  end
end
