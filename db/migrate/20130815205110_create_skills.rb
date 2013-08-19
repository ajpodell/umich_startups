class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :skill
      t.integer :user_id

      t.timestamps
    end
    add_index :skills, :skill
    add_index :skills, :user_id
  end
end
