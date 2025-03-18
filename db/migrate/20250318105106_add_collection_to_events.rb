class AddCollectionToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :collection_name, :string
    add_column :events, :collection_url, :string
  end
end
