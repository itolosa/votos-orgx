class CreateVoteCandidates < ActiveRecord::Migration
  def change
    create_table :vote_candidates do |t|
      t.references :candidate, index: true, foreign_key: true
      t.references :vote, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end