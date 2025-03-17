class ModifyEventsForeignKeyOnProperty < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :events, :properties

    add_foreign_key :events, :properties, on_delete: :nullify
  end
end
