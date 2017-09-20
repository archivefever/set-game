class CreateGameCards < ActiveRecord::Migration[5.1]
  def change
    create_table :game_cards do |t|
      t.integer   :game_id
      t.integer   :card_id
      t.string    :status

      t.timestamps
    end
  end
end
