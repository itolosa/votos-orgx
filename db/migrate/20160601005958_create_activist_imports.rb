class CreateActivistImports < ActiveRecord::Migration
  def change
    create_table :activist_imports do |t|

      t.timestamps null: false
    end
  end
end
