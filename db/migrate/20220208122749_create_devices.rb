class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :uuid, null: false

      t.timestamps
    end
    add_index :devices, :uuid, unique: true
  end
end
