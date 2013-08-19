class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :experience
      t.integer :user_id

      t.timestamps
    end
    add_index :experiences, :experience
    add_index :experiences, :user_id
  end
end
