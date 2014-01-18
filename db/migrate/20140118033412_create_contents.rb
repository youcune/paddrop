class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.string :dir, null: false
      t.string :is_dir, limit: 1, null: false, default: '0'
      t.integer :bytes, null: false
      t.datetime :modified_at, null: false

      t.timestamps

      t.index [:name, :dir]
      t.index :dir
    end
  end
end
