class CreateTravels < ActiveRecord::Migration[6.0]
  def change
    create_table :travels do |t|
      t.date :date, null: false
      t.time :time, null:false
      t.integer :duration, null: false
      t.references :starting_station, null: false, foreign_key: { to_table: :stations }
      t.references :destination_station, null: false, foreign_key: { to_table: :stations }

      t.timestamps
    end
  end
end
