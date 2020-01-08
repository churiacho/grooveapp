class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :titletag
      t.text :meta
      t.string :cover_image
      t.string :title
      t.date :date_field
      t.integer :duration_minutes

      t.timestamps
    end
  end
end
