class AddUserToFields < ActiveRecord::Migration[6.0]
  def change
    add_reference :fields, :user, null: false, foreign_key: {on_delete: :cascade}, type: :uuid
  end
end
