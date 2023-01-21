class CreateSearchTemperatures < ActiveRecord::Migration[7.0]
  def change
    create_table :search_temperatures do |t|
      t.string :temp
      t.string :location
      t.string :feels_like

      t.timestamps
    end
  end
end
