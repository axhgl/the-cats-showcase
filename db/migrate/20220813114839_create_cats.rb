class CreateCats < ActiveRecord::Migration[7.0]
  def change
    create_table :cats, id: :uuid do |t|
      t.string :remote_id, null: false, unique: true
      t.string :url, null: false, unique: true
      t.integer :width, null: false
      t.integer :height, null: false
      t.belongs_to :breed, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :cats, :remote_id
  end
end
