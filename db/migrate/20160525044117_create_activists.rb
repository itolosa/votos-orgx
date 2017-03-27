class CreateActivists < ActiveRecord::Migration
  def change
    create_table :activists do |t|
      t.string :name
      t.string :email, null: false, default: ""
      t.references :vote
      t.references :section
      t.timestamps null: false
    end
  end
end
