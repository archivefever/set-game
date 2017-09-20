class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string    :color
      t.string    :shape
      t.string    :shading
      t.integer   :number

      t.timestamps
    end
  end
end
