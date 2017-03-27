class AddTokenToActivist < ActiveRecord::Migration
  def change
    add_column :activists, :token, :string
    add_index :activists, :token, unique: true
  end
end
