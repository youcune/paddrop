class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, null: false
      t.string :sid, null: false
      t.boolean :is_deleted, null: false, defalut: false
      t.string :created_by, null: false
      t.string :updated_by, null: false

      t.timestamps

      t.index [:user_id, :sid], unique: true
    end
  end
end
