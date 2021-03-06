class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.string :destination
      t.text :description
      t.boolean :completed, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :trips, :user_id
  end
end
