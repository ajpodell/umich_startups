class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :company_id
      t.boolean :exec
      t.string :role

      t.timestamps
    end

    add_index :memberships, :user_id
    add_index :memberships, :company_id
    add_index :memberships, [:user_id, :company_id], unique: true
  end
end
