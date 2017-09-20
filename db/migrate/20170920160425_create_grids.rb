class CreateGrids < ActiveRecord::Migration[5.1]
  def change
    create_table :grids do |t|
      t.integer   :game_id
      t.boolean   :set_possible

      t.timestamps
    end
  end
end
