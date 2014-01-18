class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id, null: false
      t.string :access_token, null: false
      t.string :default_path, null: false, default: '/'
      t.string :is_deleted, limit: 1, null: false, default: '0'

      t.timestamps

      t.index :user_id, unique: true
    end
  end
end
