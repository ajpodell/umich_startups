class AddMissionToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :mission, :string
  end
end
