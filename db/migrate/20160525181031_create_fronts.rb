class CreateFronts < ActiveRecord::Migration
  def change
    create_table :fronts do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end