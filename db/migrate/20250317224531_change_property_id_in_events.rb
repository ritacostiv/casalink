class ChangePropertyIdInEvents < ActiveRecord::Migration[7.1]
  def change
    change_column_null :events, :property_id, true
  end
end
