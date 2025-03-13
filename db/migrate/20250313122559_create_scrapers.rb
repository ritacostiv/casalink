class CreateScrapers < ActiveRecord::Migration[7.1]
  def change
    create_table :scrapers do |t|
      t.string :url

      t.timestamps
    end
  end
end
