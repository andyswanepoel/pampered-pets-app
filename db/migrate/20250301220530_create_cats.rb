class CreateCats < ActiveRecord::Migration[8.0]
  def change
    create_table :cats do |t|
      t.integer :environment

      t.timestamps
    end
  end
end
