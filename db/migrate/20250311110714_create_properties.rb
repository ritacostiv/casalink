class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.string :typology
      t.boolean :garage
      t.boolean :elevator
      t.string :size
      t.string :price
      t.string :url

      t.timestamps
    end
  end
end
