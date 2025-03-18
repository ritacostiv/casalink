class AddColumnsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :user_first_name, :string
    add_column :events, :user_last_name, :string
    add_column :events, :comment_id, :bigint
    add_column :events, :comment_text, :string
  end
end
