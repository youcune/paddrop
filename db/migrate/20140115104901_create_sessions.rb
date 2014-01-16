class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, null: false, length: 16
      t.string :sid, null: false, length: 16
      t.boolean :is_deleted, null: false, defalut: false
      t.datetime :expires_at, null: false

      t.timestamps

      t.index [:user_id, :sid], unique: true
    end
  end
end
