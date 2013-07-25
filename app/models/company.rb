class Company < ActiveRecord::Base
  	attr_accessible :title, :user_id, :description
	belongs_to :user
	validates :title, presence: true

end
