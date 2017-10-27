class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.boolean   :finished, { default: false }
      t.integer   :winner
      t.string    :board, { array: true, default: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}


      t.timestamps
    end
  end
end
