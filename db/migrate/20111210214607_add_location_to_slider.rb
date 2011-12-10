class AddLocationToSlider < ActiveRecord::Migration
  def change
    remove_column :sliders, :timezone
    add_column :sliders, :timezone, :integer
    add_column :sliders, :location, :string
  end
end
