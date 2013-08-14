class AddCreatorToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :creator, :integer
  	add_index :companies, :creator
  end
end
