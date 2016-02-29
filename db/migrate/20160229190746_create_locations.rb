class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :ip
      t.string :lat
      t.string :lon
      t.string :city

      t.timestamps null: false
    end
  end
end
