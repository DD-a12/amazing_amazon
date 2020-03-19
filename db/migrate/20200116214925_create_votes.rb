class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.boolean :up_or_down
      t.timestamps
    end
  end
end
