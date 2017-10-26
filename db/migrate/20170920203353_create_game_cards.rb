class CreateGameCards < ActiveRecord::Migration[5.1]
  def change
    create_table :game_cards do |t|
      t.integer   :game_id
      t.integer   :card_id
      t.string    :status, { default: "undrawn" }
      t.integer   :board_position
      t.integer   :grouped_in_set

      t.timestamps
    end
  end
end
