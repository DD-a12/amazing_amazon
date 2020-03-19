class CreateVotings < ActiveRecord::Migration[6.0]
  def change
    create_table :votings do |t|
      t.references :review, null: false, foreign_key: true
      t.references :vote, null: false, foreign_key: true
      t.timestamps
    end
  end
end
