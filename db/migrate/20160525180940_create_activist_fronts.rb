class CreateActivistFronts < ActiveRecord::Migration
  def change
    create_table :activist_fronts do |t|
      t.references :activist
      t.references :front
      t.timestamps null: false
    end
  end
end