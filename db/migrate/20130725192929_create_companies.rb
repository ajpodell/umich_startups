class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
    add_index :companies, [:user_id, :created_at]
  end
end
