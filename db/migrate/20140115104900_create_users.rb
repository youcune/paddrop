class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id, null: false
      t.string :access_token, null: false
      t.string :default_path
      t.boolean :is_deleted, null: false, defalut: false
      t.string :created_by, null: false
      t.string :updated_by, null: false

      t.timestamps

      t.index :user_id, unique: true
    end
  end
end
