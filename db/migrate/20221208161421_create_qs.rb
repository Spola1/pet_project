class CreateQs < ActiveRecord::Migration[7.0]
  def change
    create_table :qs do |t|
      t.string :name
      t.references :answer, foreign_key: true
      t.timestamps
    end
  end
end
