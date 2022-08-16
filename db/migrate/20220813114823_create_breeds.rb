class CreateBreeds < ActiveRecord::Migration[7.0]
  def change
    create_table :breeds, id: :uuid do |t|
      t.string :remote_id, null: false, unique: true
      t.string :name, null: false, unique: true
      t.text :temperament, null: false
      t.string :origin, null: false
      t.text :description, null: false
      t.integer :child_friendly, null: false
      t.integer :cats_count, null: false, default: 0

      t.timestamps
    end
    add_index :breeds, :remote_id
    add_index :breeds, :name
  end
end
