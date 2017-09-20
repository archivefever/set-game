class CreateSetMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :set_matches do |t|
      t.integer   :game_id

      t.timestamps
    end
  end
end
