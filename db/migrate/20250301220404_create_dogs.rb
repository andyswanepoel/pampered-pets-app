class CreateDogs < ActiveRecord::Migration[8.0]
  def change
    create_table :dogs do |t|
      t.string :breed
      t.integer :activity_level

      t.timestamps
    end
  end
end
