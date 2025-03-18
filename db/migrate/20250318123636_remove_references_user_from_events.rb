class RemoveReferencesUserFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :events, :users
  end
end
