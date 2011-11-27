class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :name, :null => false
      t.string :timezone, :null => false
      t.timestamps
    end
  end
end
