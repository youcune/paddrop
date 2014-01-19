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

      t.index [:user_id, :dir, :is_dir, :name], order: {user_id: :asc, dir: :asc, is_dir: :desc, name: :asc}
      t.index [:user_id, :dir]
      t.index [:created_at]
    end
  end
end
