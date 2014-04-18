class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :display_phone
      t.string :biz_url
      t.string :thumbnail_photo
      t.string :rating
      t.integer :trip_id
      t.string :yid
      t.boolean :completed, default: false

      t.timestamps
    end
    add_index :activities, :trip_id
  end
end
