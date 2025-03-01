class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets do |t|
      t.references :pettable, polymorphic: true, null: false
      t.string :name
      t.date :date_of_birth
      t.integer :sex

      t.timestamps
    end
  end
end
