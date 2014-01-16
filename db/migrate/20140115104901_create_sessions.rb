class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, null: false
      t.string :sid, null: false, limit: 16
      t.datetime :expires_at, null: false
      t.string :is_deleted, limit: 1, null: false, default: '0'

      t.timestamps

      t.index [:user_id, :sid], unique: true
    end
  end
end
