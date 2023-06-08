class CreateAstronauts < ActiveRecord::Migration[7.0]
  def change
    create_table :astronauts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :age

      t.timestamps
    end
  end
end
