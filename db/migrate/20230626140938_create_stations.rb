class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :city, null: false

      t.timestamps
    end
    add_index :stations, :code, unique: true
  end
end
