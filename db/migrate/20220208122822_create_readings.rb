class CreateReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :readings do |t|
      t.datetime :timestamp, null: false
      t.integer :count, null: false
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
