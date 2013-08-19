class Skill < ActiveRecord::Base
	belongs_to :User

	 validates :skill, presence: true
end
