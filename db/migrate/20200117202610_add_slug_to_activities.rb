class AddSlugToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :slug, :string
  end
end
