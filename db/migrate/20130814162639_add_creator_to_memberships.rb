class AddCreatorToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :creator, :boolean
    add_index :memberships, :creator
  end
end
